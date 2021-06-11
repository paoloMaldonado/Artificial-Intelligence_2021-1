
funcs = {...
    inline( 'mean(serie((end-2+1):end))', 'serie' ),... % MM2    
    inline( 'serie( end )', 'serie' ), ...              % M-1
    inline( 'serie( end-1 )', 'serie' ), ...            % M-2
    inline( 'serie( end-2 )', 'serie' ), ...            % M-3
    inline( 'serie( end-3 )', 'serie' ), ...            % M-4 
    inline( 'serie( end-5 )', 'serie' ), ...            % M-6 
    inline( 'serie( end-11 )', 'serie' ), ...           % M-12
    };
    
  % CARGA DE LA SERIE TEMPORAL
    serieTemporal = [];
    load serieTemporal.txt;
    serie = serieTemporal;

  % PARÁMETROS A MODIFICAR 
    variablesEntrada = 7;
    numeroNeuronas = 7;
   
  % NÚMERO DE PASOS    
    validationLength = 12;    
    nSteps = validationLength;    
    windowsize = 12;
  
  % CARGANDO LOS DATOS PARA  LA PRUEBA  
    serieFinal = zeros(1,12);
    for j = 1:12
        serieFinal(13 - j) = serie(length(serie) + 1 - j);
    end
    
    mejorErrorMAPE = 100;
    mejorNumeroNeuronas = 0;
    numeroRepeticoes = 25;
       
    preProcs = [1 2 3 4 5 6 7] ;
    
    for nNeurons = 1:numeroNeuronas
         % NORMALIZANDO LA SERIE TEMPORAL
         [~,PSEndogenous] = mapminmax(serie);
         PSEndogenous.xmax = PSEndogenous.xmax * 1.18;
         PSEndogenous.xmin = PSEndogenous.xmin * 0.82;
         PSEndogenous.xrange = PSEndogenous.xmax - PSEndogenous.xmin;
         normalizedSerie = mapminmax('apply',serie,PSEndogenous);

         % CÁLCULO DE LA RNA
         somatorioErroMAPE = 0;
         for repeticoes=1:numeroRepeticoes
            [network, erro, valout, trainSequenceOut] = ClifeTrainModel_(normalizedSerie, validationLength, windowsize, nNeurons, ...
            funcs(preProcs), 1, [], nSteps, [], [], []);

            % DESNORMALIZANDO LA SALIDA DE LA RNA
            valoutDesnormalizado = mapminmax('reverse',valout,PSEndogenous);

            % EVALUANDO EL DESEMPEÑO DE LA RNA (MAPE)
            somatorioErroMAPE =  somatorioErroMAPE + ComputeMAPE(serieFinal, valoutDesnormalizado);
         end
         errorMAPE = somatorioErroMAPE/numeroRepeticoes;
         display(sprintf(strcat('COMBINACIÓN DE ENTRADAS DE LA RED: ', num2str(preProcs))));
         display(sprintf('-----------------\n'));
         
         if(errorMAPE < mejorErrorMAPE)
            mejorNumeroNeuronas = nNeurons;
            mejorPreProcs = zeros(1,2);
            mejorErrorMAPE = errorMAPE;
         end
    end
   
      
    

       
