function matrizCombinaciones_2 = exahustiva_02(variablesEntrada, subCojunto)
    i = 1;
    matrizCombinaciones_2 = zeros(21,2);
    for n = 1:variablesEntrada
        for k = 1:variablesEntrada
            if(k > n)
                temporal = [n k];
                matrizCombinaciones_2(i,1:subCojunto) = temporal;
                i = i + 1;
            end    
        end   
    end
end

