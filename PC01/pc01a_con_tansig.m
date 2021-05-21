% -----------------------------------------
% Inteligencia artificial 2021-2
% Practica Calificada 1 - parte a
% Jorge Paolo Maldonado Hurtado (17200822)
% -----------------------------------------

% Se cargan todos los elementos de entrada
% de los 12 steps en un vector fila
load inputMultistep.txt

% Se normalizan las entradas 
[Normalizada, PS] = mapminmax(inputMultistep);

% Se divide el vector fila normalizado en 8 vectores 
% fila porque la red neuronal tiene 8 entradas, para dividir
% el vector se toma el vector fila con todos los elementos y
% se dividen de 8 en 8 elementos por indice y al inicio de cada
% vector fila dividido se le agrega el bias
step1_input1 = [1 Normalizada(1:8)];
step2_input1 = [1 Normalizada(9:16)];
step3_input1 = [1 Normalizada(17:24)];
step4_input1 = [1 Normalizada(25:32)];
step5_input1 = [1 Normalizada(33:40)];
step6_input1 = [1 Normalizada(41:48)];
step7_input1 = [1 Normalizada(49:56)];
step8_input1 = [1 Normalizada(57:64)];
step9_input1 = [1 Normalizada(65:72)];
step10_input1 = [1 Normalizada(73:80)];
step11_input1 = [1 Normalizada(81:88)];
step12_input1 = [1 Normalizada(89:96)];

% Se cargan las matrices de pesos W1, W2, W3
load weight1.txt;
load weight2.txt;
load weight3.txt;

% -------------- STEP 1 -------------------------
% Se multiplica el vector fila de entrada con 
% la matriz de pesos W1 obteniendo asi un nuevo vector 
% fila al cual se le va a aplicar la funcion de activacion
% tansig. A ese ultimo resultado se le agrega el bias al inicio
% para formar el nuevo input (input 2) que sale de la primera
% hidden layer hi
step1_input2 = [1 tansig(step1_input1*weight1)];

% Se aplica el mismo proceso que en el anterior y el resultado
% obtenido es el nuevo input (input 3) que sale de la segunda
% hidden layer li
step1_input3 = [1 tansig(step1_input2*weight2)];

% Input multiplica se multiplica con el vector columna de 
% pesos W3 y a ese resultado se le aplica la funcion tansig
% dando como resultado final el output del step 1
step1_finalOutput = tansig(step1_input3*weight3);

% ----------------------------------------------------
% A partir de aqui el proceso se repite para todos los
% 11 steps restantes
% ----------------------------------------------------

% -------------- STEP 2 -------------------------
step2_input2 = [1 tansig(step2_input1*weight1)];
step2_input3 = [1 tansig(step2_input2*weight2)];
step2_finalOutput = tansig(step2_input3*weight3);

% -------------- STEP 3 -------------------------
step3_input2 = [1 tansig(step3_input1*weight1)];
step3_input3 = [1 tansig(step3_input2*weight2)];
step3_finalOutput = tansig(step3_input3*weight3);

% -------------- STEP 4 -------------------------
step4_input2 = [1 tansig(step4_input1*weight1)];
step4_input3 = [1 tansig(step4_input2*weight2)];
step4_finalOutput = tansig(step4_input3*weight3);

% -------------- STEP 5 -------------------------
step5_input2 = [1 tansig(step5_input1*weight1)];
step5_input3 = [1 tansig(step5_input2*weight2)];
step5_finalOutput = tansig(step5_input3*weight3);

% -------------- STEP 6 -------------------------
step6_input2 = [1 tansig(step6_input1*weight1)];
step6_input3 = [1 tansig(step6_input2*weight2)];
step6_finalOutput = tansig(step6_input3*weight3);

% -------------- STEP 7 -------------------------
step7_input2 = [1 tansig(step7_input1*weight1)];
step7_input3 = [1 tansig(step7_input2*weight2)];
step7_finalOutput = tansig(step7_input3*weight3);

% -------------- STEP 8 -------------------------
step8_input2 = [1 tansig(step8_input1*weight1)];
step8_input3 = [1 tansig(step8_input2*weight2)];
step8_finalOutput = tansig(step8_input3*weight3);

% -------------- STEP 9 -------------------------
step9_input2 = [1 tansig(step9_input1*weight1)];
step9_input3 = [1 tansig(step9_input2*weight2)];
step9_finalOutput = tansig(step9_input3*weight3);

% -------------- STEP 10 -------------------------
step10_input2 = [1 tansig(step10_input1*weight1)];
step10_input3 = [1 tansig(step10_input2*weight2)];
step10_finalOutput = tansig(step10_input3*weight3);

% -------------- STEP 11 -------------------------
step11_input2 = [1 tansig(step11_input1*weight1)];
step11_input3 = [1 tansig(step11_input2*weight2)];
step11_finalOutput = tansig(step11_input3*weight3);

% -------------- STEP 12 -------------------------
step12_input2 = [1 tansig(step12_input1*weight1)];
step12_input3 = [1 tansig(step12_input2*weight2)];
step12_finalOutput = tansig(step12_input3*weight3);

% Todos los outputs de los 12 steps se almacenan en un vector fila
predicted_yi = [step1_finalOutput step2_finalOutput step3_finalOutput step4_finalOutput step5_finalOutput step6_finalOutput step7_finalOutput step8_finalOutput step9_finalOutput step10_finalOutput step11_finalOutput step12_finalOutput];

% Se desnormalizan los outputs 
[Desnormalizado] = mapminmax('reverse', predicted_yi, PS );

% Desnormalizado
%            Y
%Step1	11238.97443
%Step2	11211.94392
%Step3	11647.70703
%Step4	11257.63116
%Step5	11595.69646
%Step6	11662.43587
%Step7	11703.15687
%Step8	11587.19445
%Step9	11587.76133
%Step10	11644.54671
%Step11	11317.73638
%Step12	11572.16317

