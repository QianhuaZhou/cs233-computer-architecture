INSTRUCTIONS FOR TESTING YOUR CIRCUIT

We provide a test bench (sc2_block_tb.v) that exhaustively tests 
your code, you do not need to modify it unless you want to explore. 
You will need to modify sc2_block.v. You can compile your code with 
the provided test bench with the following command:

iverilog -Wall -o sc2_block sc2_block.v sc2_block_tb.v

which will generate an executable called sc2_block which can then 
be executed by the following command:

./sc2_block

Running the executable will create a printout to the terminal that 
essentially draws a truth table of what your circuit actually 
implemented