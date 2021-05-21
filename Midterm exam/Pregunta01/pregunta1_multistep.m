% -----------------------------------------
% Inteligencia artificial 2021-2
% Examen parcial - pregunta 1 multistep
% Jorge Paolo Maldonado Hurtado (17200822)
% -----------------------------------------

% Se cargan todos los elementos de entrada
% de los 12 steps en un vector fila
load inputMultistep.txt

% Se normalizan las entradas 
[Normalizada, PS] = mapminmax(inputMultistep);

% Se divide el vector fila normalizado en 12 vectores de 6 
% elementos porque la red neuronal tiene 6 entradas, para dividir
% el vector se toma el vector fila con todos los elementos y
% se dividen de 6 en 6 elementos por indice y al inicio de cada
% vector fila dividido se le agrega el bias
step1_input1 = [-1 Normalizada(1:6)];
step2_input1 = [-1 Normalizada(7:12)];
step3_input1 = [-1 Normalizada(13:18)];
step4_input1 = [-1 Normalizada(19:24)];
step5_input1 = [-1 Normalizada(25:30)];
step6_input1 = [-1 Normalizada(31:36)];
step7_input1 = [-1 Normalizada(37:42)];
step8_input1 = [-1 Normalizada(43:48)];
step9_input1 = [-1 Normalizada(49:54)];
step10_input1 = [-1 Normalizada(55:60)];
step11_input1 = [-1 Normalizada(61:66)];
step12_input1 = [-1 Normalizada(67:72)];

% Se cargan las matrices de pesos W1, W2, W3
load weight1.txt;
load weight2.txt;
load weight3.txt;

% Se transponen las matrices para hacer posible la
% multiplicacion vector fila x vector columna 
weight1 = transpose(weight1);
weight2 = transpose(weight2);
weight3 = transpose(weight3);

% -------------- STEP 1 -------------------------
% Se multiplica el vector fila de entrada con 
% la matriz de pesos W1 obteniendo asi un nuevo vector 
% fila al cual se le va a aplicar la funcion de activacion
% tansig. A ese ultimo resultado se le agrega el bias al inicio
% para formar el nuevo input (input 2) que sale de la primera
% hidden layer hi
step1_input2 = [-1 tansig(step1_input1*weight1)];

% Se aplica el mismo proceso que en el anterior y el resultado
% obtenido es el nuevo input (input 3) que sale de la segunda
% hidden layer li
step1_input3 = [-1 tansig(step1_input2*weight2)];

% Input multiplica se multiplica con el vector columna de 
% pesos W3 y a ese resultado se le aplica la funcion tansig
% dando como resultado final el output del step 1
step1_finalOutput = tansig(step1_input3*weight3);

% ----------------------------------------------------
% A partir de aqui el proceso se repite para todos los
% 11 steps restantes
% ----------------------------------------------------

% -------------- STEP 2 -------------------------
step2_input2 = [-1 tansig(step2_input1*weight1)];
step2_input3 = [-1 tansig(step2_input2*weight2)];
step2_finalOutput = tansig(step2_input3*weight3);

% -------------- STEP 3 -------------------------
step3_input2 = [-1 tansig(step3_input1*weight1)];
step3_input3 = [-1 tansig(step3_input2*weight2)];
step3_finalOutput = tansig(step3_input3*weight3);

% -------------- STEP 4 -------------------------
step4_input2 = [-1 tansig(step4_input1*weight1)];
step4_input3 = [-1 tansig(step4_input2*weight2)];
step4_finalOutput = tansig(step4_input3*weight3);

% -------------- STEP 5 -------------------------
step5_input2 = [-1 tansig(step5_input1*weight1)];
step5_input3 = [-1 tansig(step5_input2*weight2)];
step5_finalOutput = tansig(step5_input3*weight3);

% -------------- STEP 6 -------------------------
step6_input2 = [-1 tansig(step6_input1*weight1)];
step6_input3 = [-1 tansig(step6_input2*weight2)];
step6_finalOutput = tansig(step6_input3*weight3);

% -------------- STEP 7 -------------------------
step7_input2 = [-1 tansig(step7_input1*weight1)];
step7_input3 = [-1 tansig(step7_input2*weight2)];
step7_finalOutput = tansig(step7_input3*weight3);

% -------------- STEP 8 -------------------------
step8_input2 = [-1 tansig(step8_input1*weight1)];
step8_input3 = [-1 tansig(step8_input2*weight2)];
step8_finalOutput = tansig(step8_input3*weight3);

% -------------- STEP 9 -------------------------
step9_input2 = [-1 tansig(step9_input1*weight1)];
step9_input3 = [-1 tansig(step9_input2*weight2)];
step9_finalOutput = tansig(step9_input3*weight3);

% -------------- STEP 10 -------------------------
step10_input2 = [-1 tansig(step10_input1*weight1)];
step10_input3 = [-1 tansig(step10_input2*weight2)];
step10_finalOutput = tansig(step10_input3*weight3);

% -------------- STEP 11 -------------------------
step11_input2 = [-1 tansig(step11_input1*weight1)];
step11_input3 = [-1 tansig(step11_input2*weight2)];
step11_finalOutput = tansig(step11_input3*weight3);

% -------------- STEP 12 -------------------------
step12_input2 = [-1 tansig(step12_input1*weight1)];
step12_input3 = [-1 tansig(step12_input2*weight2)];
step12_finalOutput = tansig(step12_input3*weight3);

% Todos los outputs de los 12 steps se almacenan en un vector fila
predicted_yi = [step1_finalOutput step2_finalOutput step3_finalOutput step4_finalOutput step5_finalOutput step6_finalOutput step7_finalOutput step8_finalOutput step9_finalOutput step10_finalOutput step11_finalOutput step12_finalOutput];

% Se desnormalizan los outputs 
[Desnormalizado] = mapminmax('reverse', predicted_yi, PS );

% Desnormalizado
%            Y
%Step1	12172.56252
%Step2	10618.97362
%Step3	12173.72645
%Step4	12096.66342
%Step5	12039.5467
%Step6	11455.13666
%Step7	12068.57074
%Step8	12115.80606
%Step9	12139.49096
%Step10	12131.01501
%Step11	12168.40332
%Step12	12167.43734

