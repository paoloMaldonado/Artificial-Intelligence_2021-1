function matrizCombinaciones_4 = exahustiva_05(variablesEntrada, subCojunto)
    i = 1;
    matrizCombinaciones_4 = zeros(35,4);
    for n = 1:variablesEntrada
        for k = 1:variablesEntrada
            if(k > n)
                for p = 1:variablesEntrada 
                   if (p > k)
                        for t = 1:variablesEntrada
                            if(t > p)
                                temporal = [n k p t];
                                matrizCombinaciones_4(i,1:subCojunto) = temporal;
                                i = i + 1;
                            end
                       end      
                    end     
                end
            end    
        end   
    end
end

