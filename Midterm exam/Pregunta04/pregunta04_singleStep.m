% -----------------------------------------
% Inteligencia artificial 2021-2
% Examen parcial - pregunta 1 multistep
% Jorge Paolo Maldonado Hurtado (17200822)
% -----------------------------------------

% Se cargan todos los elementos de entrada en un vector fila
load input.txt
input = transpose(input);

% Se normalizan las entradas 
[Normalizada, PS] = mapminmax(input);

% Se cargan las matrices de pesos W1, W2, W3
load weight1.txt;
load weight2.txt;
load weight3.txt;

% Agregando el bias
step1_input1 = [-1 Normalizada];

% Se transpone la matriz de pesos 1
% para hace posible la multiplicacion 
weight1 = transpose(weight1);

% Se hacen las multiplicaciones entre vectores y matrices de pesos
step1_input2 = [-1 tansig(step1_input1*weight1)];
step1_input3 = [-1 tansig(step1_input2*weight2)];
step1_finalOutput = tansig(step1_input3*weight3);

predicted_yi = step1_finalOutput;

% Se desnormaliza el output
[Desnormalizado] = mapminmax('reverse', predicted_yi, PS );

% Desnormalizado
%            Y1           Y2
%singlestep  181850994.1  169246269.4



