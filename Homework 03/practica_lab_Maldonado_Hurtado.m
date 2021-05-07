% -----------------------------------------
% Inteligencia artificial 2021-2
% Practica de laboratorio
% Jorge Paolo Maldonado Hurtado (17200822)
% -----------------------------------------

inputsMultiStep = [10861.14 11062.98 10819.26 10624.38 11306.41 10031.57 10838.18 10801.71 10930.22 10372.66 10333.73 10630.12 10037.33 11668.61 10557.22 10707.98 9376.21 8902.57 9702.23 8774.34 9630.12 9819.42 9743.64 9137.33 10332.87 10725.37 10553.61 10332.87 11374.34 11752.39 11449.89 10630.12 9543.64 9649.89 9631.55 7930.22 9732.87 9932.00 9707.98 8774.34 8932.00 9707.98 9842.97 8755.71 10930.22 8908.66 9937.33 9332.87 8908.66 8037.33 8880.33 9004.95 8755.71 8902.57 9630.12 9930.22 9613.77 9707.98 9051.35 9097.74 9204.95 9557.22 9174.34 9755.71 9613.77 9449.89 9355.76 9613.77 9097.74 9543.64 9732.87 9004.95 9102.57 9376.21 9494.99 9376.21 9613.77 9449.89 9830.22 9097.74 10707.98 10630.12 10341.21 11306.20 10376.21 10707.98 10332.87 10613.77 9702.23 9449.89 9421.59 9536.98 9306.20 10037.33 9004.95 9376.21];
[Normalizada, PS] = mapminmax(inputsMultiStep);

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

weight1 = [-0.59 0.16 -0.71 -0.13 0.14 0.27 0.19;
0.26 -0.81 0.60 0.56 0.26 0.31 -0.17;
0.48 -0.31 0.50 0.35 -0.14 0.20 0.53;
-0.37 0.24 0.34 -0.11 0.93 -0.17 0.17;
0.48 -0.62 0.72 -0.63 0.48 -0.31 0.50;
0.16 -0.71 -0.25 0.24 -0.21 0.45 -0.26;
-0.34 0.53 -0.48 -0.79 0.14 -0.34 0.29;
0.24 0.34 -0.11 0.93 -0.19 0.45 -0.26;
-0.62 0.83 -0.18 -0.27 -0.62 -0.27 0.34];

weight2 = [0.132 0.218 -0.437 0.584 -0.593 -0.437 -0.157;
-0.713 0.342 0.484 -0.593 0.267 0.484 -0.373;
-0.591 -0.133 -0.313 0.167 -0.815 -0.313 0.218;
0.431 -0.141 0.508 -0.715 0.608 0.508 0.342;
0.039 -0.257 0.478 -0.257 -0.278 0.478 -0.133;
0.371 -0.273 -0.457 -0.473 0.094 -0.457 -0.141;
0.137 -0.318 0.345 0.137 0.421 0.345 -0.257;
0.132 0.218 -0.437 0.584 -0.593 -0.437 -0.157];

weight3 = [0.853;
0.217;
-0.913;
0.742;
0.557;
0.462;
0.231;
-0.486];

step1_input2 = [1 tansig(step1_input1*weight1)];
step1_input3 = [1 tansig(step1_input2*weight2)];
step1_finalOutput = tansig(step1_input3*weight3);

step2_input2 = [1 tansig(step2_input1*weight1)];
step2_input3 = [1 tansig(step2_input2*weight2)];
step2_finalOutput = tansig(step2_input3*weight3);

step3_input2 = [1 tansig(step3_input1*weight1)];
step3_input3 = [1 tansig(step3_input2*weight2)];
step3_finalOutput = tansig(step3_input3*weight3);

step4_input2 = [1 tansig(step4_input1*weight1)];
step4_input3 = [1 tansig(step4_input2*weight2)];
step4_finalOutput = tansig(step4_input3*weight3);

step5_input2 = [1 tansig(step5_input1*weight1)];
step5_input3 = [1 tansig(step5_input2*weight2)];
step5_finalOutput = tansig(step5_input3*weight3);

step6_input2 = [1 tansig(step6_input1*weight1)];
step6_input3 = [1 tansig(step6_input2*weight2)];
step6_finalOutput = tansig(step6_input3*weight3);

step7_input2 = [1 tansig(step7_input1*weight1)];
step7_input3 = [1 tansig(step7_input2*weight2)];
step7_finalOutput = tansig(step7_input3*weight3);

step8_input2 = [1 tansig(step8_input1*weight1)];
step8_input3 = [1 tansig(step8_input2*weight2)];
step8_finalOutput = tansig(step8_input3*weight3);

step9_input2 = [1 tansig(step9_input1*weight1)];
step9_input3 = [1 tansig(step9_input2*weight2)];
step9_finalOutput = tansig(step9_input3*weight3);

step10_input2 = [1 tansig(step10_input1*weight1)];
step10_input3 = [1 tansig(step10_input2*weight2)];
step10_finalOutput = tansig(step10_input3*weight3);

step11_input2 = [1 tansig(step11_input1*weight1)];
step11_input3 = [1 tansig(step11_input2*weight2)];
step11_finalOutput = tansig(step11_input3*weight3);

step12_input2 = [1 tansig(step12_input1*weight1)];
step12_input3 = [1 tansig(step12_input2*weight2)];
step12_finalOutput = tansig(step12_input3*weight3);

predicted_yi = [step1_finalOutput step2_finalOutput step3_finalOutput step4_finalOutput step5_finalOutput step6_finalOutput step7_finalOutput step8_finalOutput step9_finalOutput step10_finalOutput step11_finalOutput step12_finalOutput];

[Desnormalizado] = mapminmax('reverse', predicted_yi, PS );

% MULTI-STEP   REAL        PREDICHO Yi
%    Step1   11254.07    11436.5749027603
%    Step2   11218.11    9949.31560178528
%    Step3   11176.83    10457.5274885248
%    Step4   11241.10    10520.6608279454
%    Step5   11295.05    10992.7173732465
%    Step6   11383.41    11328.7923497249
%    Step7   11183.25    9654.87317040136
%    Step8   11291.12    9933.92244372973
%    Step9   11280.71    10481.3516957551
%    Step10  11245.76    10479.5982801470
%    Step11  11211.23    10424.3890349263
%    Step12  11230.48    9828.30487326955
