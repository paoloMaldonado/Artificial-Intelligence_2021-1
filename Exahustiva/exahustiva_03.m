function matrizCombinaciones_3 = exahustiva_03(variablesEntrada, subConjunto)
    i = 1;
    matrizCombinaciones_3 = zeros(35,3);
    for n = 1:variablesEntrada
        for k = 1:variablesEntrada
            if(k > n)
                for p = 1:variablesEntrada 
                   if (p > k)
                       temporal = [n k p];
                       matrizCombinaciones_3(i,1:subConjunto) = temporal;
                       i = i + 1;
                    end     
                end
            end    
        end   
    end
end

