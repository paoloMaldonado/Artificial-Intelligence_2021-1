    
% ENTRADAS DE LA RED NEURONAL. 
funcs = {...
    inline( 'mean(serie((end-2+1):end))', 'serie' ),... % MM2    
    inline( 'serie( end )', 'serie' ), ...              % M-1
    inline( 'serie( end-1 )', 'serie' ), ...            % M-2
    inline( 'serie( end-2 )', 'serie' ), ...            % M-3
    inline( 'serie( end-3 )', 'serie' ), ...            % M-4 
    inline( 'serie( end-5 )', 'serie' ), ...            % M-6 
    inline( 'serie( end-11 )', 'serie' ), ...           % M-12
    };

% input [1 2 3 6] neurons: 6  
estructura_1  = [ 0 1 0 0 1 1 1   1 1 0 ];
cromossomo = estructura_1;
 
% PARÁMETROS A MODIFICAR   
numeroEntradasRed = 7;
numeroRepeticiones = 500;
    
% NÚMERO DE PASOS MULTI-STEP DE 12 MESES)   
validationLength = 12;    
nsteps = validationLength;    
windowSize = 12;
    
% CARGANDO DATOS DE LA SERIE TEMPORAL   
serieTemporal = [];
load serieTemporal.txt;
serie = serieTemporal;

% NORMALIZANDO LA SERIE TEMPORAL
[~, PS] = mapminmax(serie);
SerieNormalizada = mapminmax('apply', serie, PS);

% CODIFICANDO LAS ENTRADAS Y NEURONAS DE LA RED
preprocs = find(cromossomo(1, 1:numeroEntradasRed));
tempNeuro = int2str(cromossomo(1,(numeroEntradasRed + 1):end));
numeroNeurons = bin2dec(tempNeuro);
 
% CARGANDO LOS DATOS PARA LA PRUEBA    
serieFinal = zeros(1,12);
for j=1:12
    serieFinal(13 - j) = serie(length(serie) + 1 - j);
end

% CÁLCULO DE LA RED MLP    
mejorErrorMAPE = 100;
for repeticiones = 1:numeroRepeticiones
    [network, erro, valOut, trainSequenceOut] = ClifeTrainModel_(SerieNormalizada, validationLength, windowSize, numeroNeurons, ...
    funcs(preprocs), 1, [], nsteps, [], [], []);
    valoutDesnormalizado = mapminmax('reverse', valOut, PS);
    errorMAPE = ComputeMAPE(serieFinal, valoutDesnormalizado);
    display(sprintf('----------------------\n\n'));
    display(strcat('Repetición:  ', num2str(repeticiones)));

    % SELECCIONA LA RED CON MENOR errorMAPE
    if(errorMAPE < mejorErrorMAPE)
        mejorRede = network;
        mejorErrorMAPE = errorMAPE;
        Mejor_valOut = valoutDesnormalizado;
        display(sprintf(strcat('****** mejorErrorMAPE es igual a:  ' , num2str(mejorErrorMAPE))));
    end
end
  
    
    