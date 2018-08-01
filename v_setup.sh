#!/bin/bash

#Screenshots a portion of the screen to use as an input for the decrypter

#screencapture -c -x -t jpg /Users/Takuma/Desktop/ECE499/ECE499_V_Encryption/prototype/input/input.jpg 


#tmux new -s matlab "/Applications/MATLAB_R2017b.app/bin/matlab -nodesktop -nojvm"

counter=0;
iterations=1000;

start=$SECONDS;

while [ $counter -le $iterations ]
do
	screencapture -x -R450,95,400,400 -t jpg /Users/Takuma/Desktop/ECE499/ECE499_V_Encryption/prototype/output/1.jpg 
	(( counter++ ))

done

duration=$(( SECONDS - start ))

echo "$iterations Iterations Completed in $duration Seconds"