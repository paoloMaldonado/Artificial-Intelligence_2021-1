
% this is a low-level function: no parameter checking is done and no parameter
% is optional!
function [network, erro, valout, trainSequenceOut] = ClifeTrainModel_(series, ...
    validationLength, windowSize, neurons, functions, numberOfTrains, ...
    seriesExplicativas, numberOfForecastSteps, ...
    conn, host_id, validationDates)
%% Net inputs build-up for training

% build train series. The last "validationLength" samples are used for
% validation.
serie_train = series(1 : (length(series)-validationLength));

% the extraSeries is assumed to have the correct inputs for targets on
% "serie". For example, extraSeries(i) is a network input for forecasting
% series(i+1). Therefore, length(serie_train)-1 is used intead of
% length(serie_train).

if ~isempty(seriesExplicativas)
    seriesExplicativasTreino = seriesExplicativas(:, 1:(length(serie_train)-1));
else
    seriesExplicativasTreino = [];
end
[base_train.inputs base_train.targets] = PrepareSeriesForNet(...
                                                serie_train,...
                                                windowSize,...
                                                functions,...
                                                seriesExplicativasTreino...
                                                );

%% validation preparations

% prepara as janelas pre-processadas para validação
serie_valida = series((length(series)-validationLength+1) : end);

% the extraSeries is assumed to have the correct inputs for targets on
% "serie". For example, extraSeries(i) is a network input for forecasting
% series(i+1). Therefore, (end - validationLength):(end-1) is used intead
% of (end - validationLength+1):end.
if ~isempty(seriesExplicativas)
    %seriesExplicativasVal = seriesExplicativas(:, (end - validationLength):(end-1));
    seriesExplicativasVal = seriesExplicativas(:, (end - validationLength+1):end);
else
    seriesExplicativasVal = [];
end

%%%this is the preprocessor used by MultistepSimulate
F = @(window) preprocess(window, functions);

%the first validation input is the last window of training series.
base_val.input = serie_train((end-windowSize+1):end);
base_val.targets = serie_valida;


%% prepare variables for training
erro_min = ones(1, numberOfTrains) .* 1e15;
rede_opt = cell(1, numberOfTrains);
valtemp = cell(1, numberOfTrains);
trainSequences = cell(1, numberOfTrains);

maximumIterations = 1000;

%% Trains
inputsForThisNet = base_train.inputs;
targetsForThisNet = base_train.targets;
for trains = 1 : numberOfTrains
    
    
%     ANTIGO (network creation)
%      network = newff( inputsForThisNet, targetsForThisNet, neurons, ...
%         { 'tansig', 'purelin' }, 'trainlm', ...
%         'learngdm', 'mse', { 'mapminmax' }, { 'mapminmax' }, 'dividerand' );

%     NOVO
     network = newff( inputsForThisNet, targetsForThisNet, neurons, ...
       { 'tansig', 'purelin' }, 'trainlm', ...
       'learngdm', 'mse', { 'removeconstantrows' }, { 'removeconstantrows' }, 'dividerand' );
    
    network.trainParam.goal        = 1e-8;
    network.divideParam.trainRatio = 1;
    network.divideParam.valRatio   = 0;
    network.divideParam.testRatio  = 0;
    network.trainParam.lr          = 0.05;
    
    network.trainParam.epochs      = 1;
    network.trainParam.showWindow  = false;
    maxValErrorChecks = 25;
    
    % training
    sequentialValidantionsPosLastMinimum = 0;
    
    [erro_min(trains), rede_opt{trains}, valtemp{trains}, trainSequence] = ...
        TrainNetwork(network, base_train, maximumIterations, maxValErrorChecks, ...
        sequentialValidantionsPosLastMinimum, base_val, seriesExplicativasVal,...
        numberOfForecastSteps, F, windowSize);
    
    
    trainSequences{trains} = trainSequence;
    
    errosVal = valtemp{trains} - base_val.targets;
    
    if length(errosVal)<4
        ttestVal=0;
        lillieVal=0;
    else
    
        ttestVal = ttest(errosVal);
        lillieVal = lillietest(errosVal);
    end
    
    if (lillieVal~=0) || (ttestVal~=0)
        erro_min(trains) = inf;
        
    end
    
    %display(sprintf('Rede: %d, RMSE: %.2f\n', trains, sqrt(erro_min(trains))));
    
end

%% Salvando as melhores configurações
[erro, index] = min(erro_min);
network         = rede_opt{index};
valout          = valtemp{index};
trainSequenceOut =  trainSequences{index};

end


function [erro_min, rede, val, trainSequence] = TrainNetwork(network, ...
    base_train, maximumIterations, maxValErrorChecks, ...
        sequentialValidantionsPosLastMinimum, base_val, ...
        seriesExplicativasVal, numberOfForecastSteps, F, windowSize)
    
    trainSequence.trainMSE = zeros(1, maximumIterations);
    trainSequence.validationMSE = zeros(1, maximumIterations);
    
    erro_min = inf;
    rede = network;
    val = [];
    for i = 1 : maximumIterations
        
        % mu update after first step
        if i>1
            network.trainParam.mu = min(...
                                        [...
                                            mi,...
                                            network.trainParam.mu_max...
                                        ]...
                                    );
        end
        [network tr] = train(network, base_train.inputs, base_train.targets);
        mi = tr.mu(end);
        
        [error_temp out] = Validate(network, base_val.input, ...
            base_val.targets, seriesExplicativasVal, ...
            numberOfForecastSteps, F, windowSize);
        
        if isempty(val)
           val = out; 
        end
        
        trainSequence.trainMSE(1, i) = tr.perf(end);
        trainSequence.validationMSE(1, i) = error_temp;
        
        if error_temp < erro_min
            
            erro_min = error_temp;
            rede = network;
            val  = out;            
            sequentialValidantionsPosLastMinimum = 0;
            
        else
            
            sequentialValidantionsPosLastMinimum = sequentialValidantionsPosLastMinimum+1;
            if sequentialValidantionsPosLastMinimum > maxValErrorChecks
                
                %resize trainSequence
                trainSequence.trainMSE = trainSequence.trainMSE(1:i);
                trainSequence.validationMSE = trainSequence.validationMSE(1:i);                
                
                break;              
            end
            
        end
        
    end
    
end

function [inputs targets] = PrepareSeriesForNet(series, windowSize,...
    functions, extraSeries)
    windowizedTrainSeries = windowize(series(1:(end-1)), windowSize);
    inputs = preprocess(windowizedTrainSeries, functions);

    numberOfWindows = length(inputs);

    targets = series((end-numberOfWindows+1):end);

    % it is assumed that extraSeries is aligned with the targets, that is,
    % the extraSeries(i) is the correct input for forecasting series(i).
    if ~isempty(extraSeries)
        inputs=[inputs; extraSeries(:, (end-numberOfWindows+1):end)];
    end
end
%%%
%%%



%%%