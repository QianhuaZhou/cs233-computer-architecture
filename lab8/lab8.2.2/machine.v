module machine(clk, reset);
   input        clk, reset;

   wire [31:0]  PC;
   wire [31:2]  next_PC, next_PC_1, next_PC_2, PC_plus4, PC_target;
   wire [31:0]  inst;

   wire [31:0]  imm = {{ 16{inst[15]} }, inst[15:0] };  // sign-extended immediate
   wire [4:0]   rs = inst[25:21];
   wire [4:0]   rt = inst[20:16];
   wire [4:0]   rd = inst[15:11];

   wire [4:0]   wr_regnum;
   wire [2:0]   ALUOp;

   wire         RegWrite, BEQ, ALUSrc, MemRead, MemWrite, MemToReg, RegDst, MFC0, MTC0, ERET;
   wire         PCSrc, zero, negative;
   wire [31:0]  rd1_data, rd2_data, B_data, alu_out_data, load_data, wr_data;

   //Your extra wires go here
   wire[31:0] temp_wr_data;

   wire [31:0] c0_rd_data;
   wire [29:0] EPC;
   wire        TakenInterrupt;
   wire [31:0] c0_wr_data;
   wire        TimerInterrupt;

   wire [31:0] cycle;
   wire        TimerAddress;
   wire [31:0] t_data, t_address;
   

   register #(30, 30'h100000) PC_reg(PC[31:2], next_PC, clk, /* enable */1'b1, reset);
   assign PC[1:0] = 2'b0;  // bottom bits hard coded to 00
   adder30 next_PC_1_adder(PC_plus4, PC[31:2], 30'h1);
   adder30 target_PC_adder(PC_target, PC_plus4, imm[29:0]);
   mux2v #(30) branch_mux(next_PC_1, PC_plus4, PC_target, PCSrc);

   mux2v #(30) ERET_mux(next_PC_2, next_PC_1, EPC, ERET);
   wire [31:0] intr_hand = {32'h80000180};
   mux2v #(30) Taken_Interrupt_mux(next_PC, next_PC_2, intr_hand[31:2], TakenInterrupt);

   assign PCSrc = BEQ & zero;

   instruction_memory imem (inst, PC[31:2]);

   mips_decode decode(ALUOp, RegWrite, BEQ, ALUSrc, MemRead, MemWrite, MemToReg, RegDst, MFC0, MTC0, ERET,
                      inst);

   regfile rf (rd1_data, rd2_data,
               rs, rt, wr_regnum, wr_data,
               RegWrite, clk, reset);

   assign c0_wr_data = rd2_data;//
   assign t_data = rd2_data;//
   
   mux2v #(32) imm_mux(B_data, rd2_data, imm, ALUSrc);
   alu32 alu(alu_out_data, zero, negative, ALUOp, rd1_data, B_data);

   assign t_address = alu_out_data;//

   data_mem data_memory(load_data, alu_out_data, rd2_data, MemRead & (~TimerAddress), MemWrite & (~TimerAddress), clk, reset);

   assign load_data = cycle;//
   mux2v #(32) wb_mux(temp_wr_data, alu_out_data, load_data, MemToReg);
   
   
   mux2v #(32) wr_data_mux(wr_data, temp_wr_data, c0_rd_data, MFC0);
   mux2v #(5) rd_mux(wr_regnum, rt, rd, RegDst);

   cp0 cp0_mux(c0_rd_data, EPC, TakenInterrupt, c0_wr_data, rd, next_PC_1,
   MTC0, ERET, TimerInterrupt, clk, reset);
   timer timer_mux(TimerInterrupt, cycle, TimerAddress, t_data, t_address, MemRead, MemWrite, clk, reset);

  
   

endmodule // machine
