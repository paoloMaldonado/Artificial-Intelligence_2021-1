
function windows = windowize(knownTargetDepedentInput, windowSize)
    %% parameter explanation
    % knownTargetDepedentInput = input series to windowize. Sucessive
    %   columns are considered to be sucessive series elements. Each element
    %   is a column of "knownTargetDepedentInput" parameter.
    
    % windowSize = the size (number of elements) of the window.
    
    % windows = cell array (1 x number of windows). Each cell element is a
    %   window. Each window is a matrix, whose lines are the corresponding
    %   elements of knownTargetDepedentInput.  
    
    %% variable preparing        
    seriesLength = size(knownTargetDepedentInput, 2);
    numberOfWindows = seriesLength - windowSize + 1;
    windows = cell(1, numberOfWindows);
    
    %% window filling    
    for seriesIndex = 1:numberOfWindows
        windows{seriesIndex} = knownTargetDepedentInput(:, ...
            seriesIndex:(seriesIndex+windowSize-1)).'; %tranpose but don't conjugate!
    end
    
end