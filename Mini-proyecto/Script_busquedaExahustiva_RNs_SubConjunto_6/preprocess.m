%% preprocess method
function y = preprocess(x, inputProcessingFunctions)

    if isfloat(x) %in this case, x is a single window. The output is a column-vector
        y = zeros(length(inputProcessingFunctions), 1);
        for index = 1:length(inputProcessingFunctions)
            thisFunction = inputProcessingFunctions{index};
            y(index, 1) = thisFunction(x);
        end
    elseif iscell(x)
        y = zeros(length(inputProcessingFunctions), length(x));
        for windowIndex = 1:length(x)
            for index = 1:length(inputProcessingFunctions)
                thisFunction = inputProcessingFunctions{index};
                y(index, windowIndex) = thisFunction(x{windowIndex}...
                    );
            end
        end
    end

end