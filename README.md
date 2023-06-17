Program for seeking of MSB position in input number and translate it into number of bit

Calculating of new MSB position starts on each changing of input data block. After each changing
module is insensible to all following changings until MSB position is found. busy_o signal shows if 
and when module is insensible or become sensible to changings again

Features:
-Speed up by 2 times by seeking from two sides
