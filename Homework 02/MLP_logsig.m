weights1 = [-0.59 0.16 -0.71 -0.13 0.14 0.75 -0.37; 
         0.26 -0.81 0.60  0.56 0.26 0.34 -0.11; 
         0.48 -0.31 0.50  0.35 -0.14 0.72 -0.63;
        -0.37 0.24 0.34 -0.11 0.93 -0.25 -0.31;
         0.48 -0.62 0.72 -0.63 0.48 -0.48 0.24;
         0.16 -0.71 -0.25 0.24 -0.21 -0.59 -0.25;
        -0.34 0.53 -0.48 -0.79 0.14 0.26 -0.27];
       
inputs1 = [-1 -0.29854 0.87613 -0.12085 -0.49359 0.67181 0.48274];

output1 = inputs1 * weights1;
inputs2 = [-1 logsig(output1)];

weights2 = [0.132 -0.713 -0.591 0.431 0.039
            0.218 0.342 -0.133 -0.141 -0.257
           -0.437 0.484 -0.313 0.508 0.478
            0.584 -0.593 0.167 -0.715 -0.257
           -0.593 0.267 -0.815 0.608 -0.278
           -0.437 0.484 -0.313 0.508 0.478
           -0.913 0.752 0.484 -0.437 0.218
            0.742 -0.833 -0.593 0.584 -0.437];
        
output2 = inputs2 * weights2;
inputs3 = [-1 logsig(output2)];
        
weights3 = [0.853 0.442 -0.713
            0.217 0.557 0.342
           -0.913 0.752 0.484
            0.742 -0.833 0.752
            0.557 0.378 -0.833
            0.462 0.658 -0.173];
        
output3 = inputs3 * weights3;
finaloutput = logsig(output3);