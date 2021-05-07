
function mape = CallBasicMLP(cromosoma, numeroEntradasRed)
    % SE DEFINEN LAS ENTRADAS DE LA RED NEURONAL MLP. 
    funcs = {...
        inline( 'serie( end )', 'serie' ), ...                  %M-1
        inline( 'serie( end-1 )', 'serie' ), ...                %M-2
        inline( 'serie( end-2 )', 'serie' ), ...                %M-3
        inline( 'serie( end-3 )', 'serie' ), ...                %M-4
        inline( 'serie( end-5 )', 'serie' ), ...                %M-6
        inline( 'serie( end-11 )', 'serie' ), ...               %M-12
        inline( 'serie( end ) - serie( end-1 )', 'serie' ), ... %D(1-2)
        inline( 'serie( end ) - serie( end-2 )', 'serie' ), ... %D(1-3)
        inline( 'mean(serie((end-2+1):end))', 'serie' ),...     %MM(1,2)
        inline( 'mean(serie((end-3+1):end))', 'serie' ), ...    %MM3(1,2,3)
        };

    % PARÁMETROS A MODIFICAR   
    numeroRepeticiones = 25;

    % NÚMERO DE PASOS Y WINDOWSIZE     
    validationLength = 12;    
    nsteps = validationLength;    
    windowSize = 12;

    % CARGANDO DATOS DE LA SERIE TEMPORAL   
    datos = [];
    load datos.txt;
    serie = datos;
    
    % NORMALIZANDO LA SERIE TEMPORAL
    [~, PS] = mapminmax(serie);
    SerieNormalizada = mapminmax('apply', serie, PS);

    % CODIFICANDO LAS ENTRADAS Y NEURONAS DE LA RED
    preprocs = find(cromosoma(1, 1:numeroEntradasRed));
    tempNeuro = int2str(cromosoma(1,(numeroEntradasRed + 1):end));
    numeroNeurons = bin2dec(tempNeuro);

    % CARGANDO LOS DATOS PARA LA PRUEBA    
    serieFinal = zeros(1,12);
    for j=1:12
        serieFinal(13 - j) = serie(length(serie) + 1 - j);
    end

    % EJECUCIÓN DEL MLP    
    for repeticiones = 1:numeroRepeticiones
        [network, erro, valOut, trainSequenceOut] = ClifeTrainModel_(SerieNormalizada, validationLength, windowSize, numeroNeurons, ...
        funcs(preprocs), 1, [], nsteps, [], [], []);
        valoutDesnormalizado = mapminmax('reverse', valOut, PS);
        errorMAPE(repeticiones) = ComputeMAPE(serieFinal, valoutDesnormalizado);
        display(sprintf('----------------------\n\n'));
        display(strcat('Repetición:  ', num2str(repeticiones)));
    end
    mape = mean(errorMAPE(1:numeroRepeticiones));
end
  
    
    