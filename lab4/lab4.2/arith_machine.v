// arith_machine: execute a series of arithmetic instructions from an instruction cache
//
// except (output) - set to 1 when an unrecognized instruction is to be executed.
// clock  (input)  - the clock signal
// reset  (input)  - set to 1 to set all registers to zero, set to 0 for normal execution.

module arith_machine(except, clock, reset);
    output      except;
    input       clock, reset;

    wire [4:0]  rs;
    wire [4:0]  rt;
    wire [4:0]  rd;
    wire [5:0]  opcode;
    wire [5:0]  funct;

    wire        wr_enable;
    wire        rd_src;
    wire [1:0]  alu_src2;
    wire [2:0]  alu_op;

    wire [4:0]  w_addr;
    wire [31:0] Rrs, Rrt, B_data;
    wire [31:0] w_data;
    wire        overflow, zero, negative;
    wire [31:0] sextimm, zextimm;

    // Complete the Control FSM components and add any missing components that you need

    register #(32) PC_reg( /* FILL IN THE BLANKS */ );

    instruction_memory im (/* FILL IN THE BLANKS*/);


    // Arithmetic Machine Datapath

    // sign-extended immediate
    assign sextimm = { {16{inst[15]}}, inst[15:0] };

    // zero-extended immediate
    assign zextimm = { {16{1'b0}}, inst[15:0] };

    // Register File and ALU
    mux2v #(5) rd_mux(w_addr, rd, rt, rd_src);

    regfile rf (Rrs, Rrt,
                rs, rt, w_addr, w_data,
                wr_enable, clock, reset);

    mux3v alu_src2_mux(B_data, Rrt, sextimm, zextimm, alu_src2);

    alu32 alu(w_data, overflow, zero, negative, Rrs, B_data, alu_op);

endmodule // arith_machine