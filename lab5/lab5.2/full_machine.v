// full_machine: execute a series of MIPS instructions from an instruction cache
//
// except (output) - set to 1 when an unrecognized instruction is to be executed.
// clock   (input) - the clock signal
// reset   (input) - set to 1 to set all registers to zero, set to 0 for normal execution.

module full_machine(except, clock, reset);
    output      except;
    input       clock, reset;
    wire [31:0] inst;
    wire [4:0]  rs = inst[25:21];
    wire [4:0]  rt = inst[20:16];
    wire [4:0]  rd = inst[15:11];
    wire [4:0]  shamt = inst[10:6];
    wire [5:0]  opcode = inst[31:26];
    wire [5:0]  funct = inst[5:0];

    wire        wr_enable;
    wire        rd_src;
    wire [1:0]  alu_src2, control_type;
    wire [2:0]  alu_op;
    
    wire [4:0]  w_addr;
    wire [31:0] Rrs, Rrt, B_data;
    wire [31:0] w_data;
    wire        overflow, zero, negative, byte_load, word_we, byte_we, clock, mem_read, slt, lui, addm;
    wire [31:0] sextimm, zextimm;
    wire [31:0] next_PC, PC, plus_PC, branch_PC, branchAddr, jumpAddr, shift_out;

    //1.decorder
    mips_decode mip(alu_op, wr_enable, rd_src, alu_src2, except, control_type,
mem_read, word_we, byte_we, byte_load, slt, lui, addm,
opcode, funct, zero);
    //2. PC control_type
    alu32 pc_plus4(plus_PC,,,, PC, 32'h4, `ALU_ADD);
    register #(32) PC_reg(PC, next_PC, clock, 1'b1, reset);
    assign branchAddr = {{14{inst[15]}}, inst[15:0], 2'b0};
    alu32 pc_branchAddr(branch_PC,,,, plus_PC, branchAddr, `ALU_ADD);
    assign jumpAddr = {plus_PC[31:28], inst[25:0], 2'b0};
    mux4v pc_control(next_PC, plus_PC, branch_PC, jumpAddr, Rrs, control_type);

    //3. instruction memory
    instruction_memory im (inst, PC[31:2]);
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
    
   
    
    //4. slt--how to fix it?
    //assign negative = alu_result[31];
    wire [31:0] alu_result, negative_extend, slt_out;
    alu32 alu(alu_result, overflow, zero, negative, Rrs, B_data, alu_op);
    wire slt_jude;
    assign slt_jude = overflow ^ negative;//is this correct? why?
    assign negative_extend = {31'b0, slt_jude};
    //assign negative_extend = {31'b0, negative};
    mux2v #(32) slt_mux(slt_out, alu_result, negative_extend, slt);

    //5. Data memory
    wire [31:0] data_out, data_out_byte, byte_load_out;
    data_mem data_m(data_out, alu_result, Rrt, word_we, byte_we, clock, reset);
    //Byte load
    mux4v #(32) data_byte_divided(data_out_byte, {24'b0, data_out[7:0]}, {24'b0, data_out[15:8]}, {24'b0, data_out[23:16]}, {24'b0, data_out[31:24]}, alu_result[1:0]);
    mux2v #(32) byte_load_mux(byte_load_out, data_out, data_out_byte, byte_load);
    
    //6. memory read
    wire [31: 0] mem_read_out;
    mux2v #(32) mem_read_mux(mem_read_out, slt_out, byte_load_out, mem_read);
    
    //7. lui
    wire [31:0] lui_out;
    mux2v #(32) lui_mux(lui_out, mem_read_out, {inst[15:0], 16'b0}, lui);

    //8. addm
    wire [31:0] addm_out;
    alu32 addm_alu(addm_out, , , , Rrt, data_out, `ALU_ADD);
    mux2v #(32) addm_mux(w_data, lui_out, addm_out, addm);
    wire [31:0] zeros;
    assign zeros = {32'b0};
    mux4v alu_src2_mux(B_data, Rrt, sextimm, zextimm, zeros, alu_src2);

  
endmodule // full_machine
