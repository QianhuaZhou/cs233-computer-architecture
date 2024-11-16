Instructions for testing your circuit

We provide a test bench that exhaustively tests your code. You can compile your code with the provided test bench with the following command:

     iverilog -Wall -o comparator8_exe comparator1.v comparator8.v comparator8_tb.v

which will generate an executable called 'comparator1_exe' which can then be executed by the following command:

     ./comparator8_exe

Alternatively, you can use the make file to do this all for you with the following command:

     make comparator8