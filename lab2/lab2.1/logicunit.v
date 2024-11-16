module mux4v(out, A, B, C, D, control);
    output      out;
    input       A, B, C, D;
    input [1:0] control;

    wire  wA, wB, wC, wD;

    assign wA = A & (control == 2'b00);
    assign wB = B & (control == 2'b01);
    assign wC = C & (control == 2'b10);
    assign wD = D & (control == 2'b11);

    or  o1(out, wA, wB, wC, wD);

endmodule // mux4v

// Design a logicunit that implements the specified truth table
module logicunit(out, A, B, control);
    output      out;
    input       A, B;
    input [1:0] control;

    // Add your code here
    wire a1, o1, n1, x1;
    assign a1 = A & B;
    assign o1 = A | B;
    //assign n1 = A ~| B;
    nor n_1(n1, A, B);
    assign x1 = A ^ B;
    mux4v mux_1(out, a1, o1, n1, x1, control);
    

   
endmodule // Logic Unit to Verilog

