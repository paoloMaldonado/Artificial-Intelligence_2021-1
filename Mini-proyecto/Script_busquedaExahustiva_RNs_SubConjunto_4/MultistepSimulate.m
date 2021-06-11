function outputs = MultistepSimulate(net, knownTargetDepedentInput, ...
    windowSize, inputProcessingFunction, numberOfSteps, seriesExplicativas)
    %% parameter explanation
    % net = trained neural network.
    
    % knownTargetDepedentInput = the input to be processed by the
    %   inputProcessingFunction parameter. The outputs of the network "net"
    %   are right-concatenated to the knownTargetDepedentInput matrix,
    %   processed by the inputProcessingFunction and are used as input to
    %   "net" in order to compute the new output. Sucessive samples are
    %   considered to be in sucessive columns.
    
    % windowSize = number of elements on the window used on the
    %   "knownTargetDepedentInput" series.
    
    % inputProcessingFunction: see description of
    %   "knownTargetDepedentInput". This is a MATLAB function that receives
    %   a window of size given by "windowSize" parameter, process the
    %   window and give a column-vector output that is used as input to the
    %   "net" neural network.
    
    % numberOfSteps = number of outputs.
    
    % seriesExplicativas = additional series for input. These series are
    %   NOT pre-processed by inputProcessingFunction. This parameter is a
    %   N cell array, wher N = number of windows. Each element of the cell
    %   array is a matrix with L columns, where L = numberOfSteps.
    %   Therefore, for each window and for each step it is allowed a single
    %   vector input.
    
    % output = a cell (1 x number of windows) whose entries are matrices.
    %   Each matrix is the multistep simulation for a single window. 
    %   Therefore, each matrix has N lines by M columns, where 
    %   N = number of network outputs and M = number of steps.
    
    %% parameter checking
    if net.numOutputs ~= size(knownTargetDepedentInput, 1)
       error('Número de variáveis dependentes da saída da rede é diferente do número de saídas da rede.'); 
    end
    
    if nargin < 6
        seriesExplicativas = [];
    end
    
    %% variables preparing
    windows = windowize(knownTargetDepedentInput, windowSize);
    numberOfWindows = size(windows, 2);
    
    % the output is a cell
    outputs = cell(1, numberOfWindows);
    
    %% window simulation
    for windowIndex=1:numberOfWindows
        
        %pre-initialize output matrix for speed.
        thisWindowOutputMatrix = zeros(net.numOutputs, numberOfSteps);
        
        %used to concatenate with new results and generate new windows
        thisWindowSeries = windows{windowIndex};
        
        %this is the extra series input for this window.
        if ~isempty(seriesExplicativas)
            thisWindowExtraSeries = seriesExplicativas{windowIndex};
        end
        
        for step=1:numberOfSteps     

            %apply pre-processing
            netInputsTemp = inputProcessingFunction(thisWindowSeries);
            
            %concatenate extra series
            if isempty(seriesExplicativas)
                netInputs = netInputsTemp;
            else
                netInputs = [netInputsTemp; thisWindowExtraSeries(:, step)];
            end

            %simulate
            output = sim(net, netInputs).';%transpose but don't conjugate.
            
            %assign to output matrix
            thisWindowOutputMatrix(:, step) = output;
            
            %concatenate the window buffer
            thisWindowSeries = [thisWindowSeries(2:end, :); output];
            
        end
        
        %assign to the output
        outputs{windowIndex} = thisWindowOutputMatrix;
        
    end
    
end


%%%%%%