% Function to build a new pattern based on the last value
function [ error output ] = Validate(network, input, ...
                targets, seriesExplicativasVal,...
                numberOfForecastSteps, preprocessorFunction,...
                windowSize)
    
            if isempty(seriesExplicativasVal)
                output = MultistepSimulate(network, input, windowSize, ...
        preprocessorFunction, numberOfForecastSteps);
            else
    output = MultistepSimulate(network, input, windowSize, ...
        preprocessorFunction, numberOfForecastSteps, ...
        {seriesExplicativasVal});
            end
    
    output = output{1};
    
    %Erro médio quadrático - MSE    
    error = mean( (targets - output) .* (targets - output) );
end