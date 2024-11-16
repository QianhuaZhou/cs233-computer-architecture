Instructions for testing your circuit

We provide a test bench that exhaustively tests your code. You can compile your code with the provided test bench with the following command:

     iverilog -Wall -o sop_circuit sop_circuit.v sop_circuit_tb.v

which will generate an executable called 'sop_circuit' which can then be executed by the following command:

     ./sop_circuit