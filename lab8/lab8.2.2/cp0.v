`define CAUSE_REGISTER  5'd13
`define EPC_REGISTER    5'd14

module cp0(rd_data, EPC, TakenInterrupt,
           wr_data, regnum, next_pc,
           MTC0, ERET, TimerInterrupt, clock, reset);
    output [31:0] rd_data;
    output [29:0] EPC;
    output        TakenInterrupt;
    input  [31:0] wr_data;
    input   [4:0] regnum;
    input  [29:0] next_pc;
    input         MTC0, ERET, TimerInterrupt, clock, reset;

    // your Verilog for coprocessor 0 goes here
    wire[31:0] decorder_out, user_status;
    wire[29:0] taken_interrupt_out;
    wire exception_level;
    wire[1:0] sel;
    wire[31:0] cause_register, status_register;
    wire and_out_1, and_out_2;

    assign status_register = {16'b0, user_status[15:8], 6'b0, exception_level, user_status[0]};
    assign cause_register = {16'b0, TimerInterrupt, 15'b0};       // Initialize all bits to 0


    decoder32 decorder_32(decorder_out, regnum, MTC0);

    mux2v #(30) taken_interrupt(taken_interrupt_out, wr_data[31:2], next_pc, TakenInterrupt);

    register user_status_mux(user_status, wr_data, clock, decorder_out[12], reset);
    
    dffe exception_level_register(exception_level, 1'd1, clock, TakenInterrupt, reset | ERET);
  
    register #(30, 0) EPC_register(EPC, taken_interrupt_out, clock, decorder_out[14] || TakenInterrupt, reset);

    mux32v rdmux(rd_data, 32'b0, 32'b0, 32'b0, 32'b0, 32'b0, 32'b0, 32'b0, 32'b0, 32'b0, 32'b0,
    32'b0, 32'b0, status_register[31:0], cause_register[31:0], {EPC, 2'b0},32'b0, 32'b0, 32'b0,
    32'b0, 32'b0, 32'b0, 32'b0, 32'b0, 32'b0, 32'b0, 32'b0, 32'b0, 32'b0, 32'b0, 32'b0, 32'b0, 32'b0, regnum);

    assign and_out_1 = cause_register[15] & status_register[15];
    assign and_out_2 = (~status_register[1]) & status_register[0];
    assign TakenInterrupt = and_out_1 & and_out_2;
    

endmodule