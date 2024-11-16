module decoder_test;
    reg [5:0] opcode, funct;
    reg       zero  = 0;

    initial begin
        $dumpfile("decoder.vcd");
        $dumpvars(0, decoder_test);
/*
        // Test ADD instruction (R-type)
        opcode = `OP_OTHER0; funct = `OP0_ADD;
        #10 $display("Test ADD: alu_op=%b, writeenable=%b, rd_src=%b, alu_src2=%b, except=%b, control_type=%b, mem_read=%b, word_we=%b, byte_we=%b, byte_load=%b, slt=%b, lui=%b, addm=%b",
                     alu_op, writeenable, rd_src, alu_src2, except, control_type, mem_read, word_we, byte_we, byte_load, slt, lui, addm);

        // Test SUB instruction (R-type)
        opcode = `OP_OTHER0; funct = `OP0_SUB;
        #10 $display("Test SUB: alu_op=%b, writeenable=%b, rd_src=%b, alu_src2=%b, except=%b, control_type=%b, mem_read=%b, word_we=%b, byte_we=%b, byte_load=%b, slt=%b, lui=%b, addm=%b",
                     alu_op, writeenable, rd_src, alu_src2, except, control_type, mem_read, word_we, byte_we, byte_load, slt, lui, addm);

        // Test AND instruction (R-type)
        opcode = `OP_OTHER0; funct = `OP0_AND;
        #10 $display("Test AND: alu_op=%b, writeenable=%b, rd_src=%b, alu_src2=%b, except=%b, control_type=%b, mem_read=%b, word_we=%b, byte_we=%b, byte_load=%b, slt=%b, lui=%b, addm=%b",
                     alu_op, writeenable, rd_src, alu_src2, except, control_type, mem_read, word_we, byte_we, byte_load, slt, lui, addm);

        // Test OR instruction (R-type)
        opcode = `OP_OTHER0; funct = `OP0_OR;
        #10 $display("Test OR: alu_op=%b, writeenable=%b, rd_src=%b, alu_src2=%b, except=%b, control_type=%b, mem_read=%b, word_we=%b, byte_we=%b, byte_load=%b, slt=%b, lui=%b, addm=%b",
                     alu_op, writeenable, rd_src, alu_src2, except, control_type, mem_read, word_we, byte_we, byte_load, slt, lui, addm);

        // Test XOR instruction (R-type)
        opcode = `OP_OTHER0; funct = `OP0_XOR;
        #10 $display("Test XOR: alu_op=%b, writeenable=%b, rd_src=%b, alu_src2=%b, except=%b, control_type=%b, mem_read=%b, word_we=%b, byte_we=%b, byte_load=%b, slt=%b, lui=%b, addm=%b",
                     alu_op, writeenable, rd_src, alu_src2, except, control_type, mem_read, word_we, byte_we, byte_load, slt, lui, addm);

        // Test SLT instruction (R-type)
        opcode = `OP_OTHER0; funct = `OP0_SLT;
        #10 $display("Test SLT: alu_op=%b, writeenable=%b, rd_src=%b, alu_src2=%b, except=%b, control_type=%b, mem_read=%b, word_we=%b, byte_we=%b, byte_load=%b, slt=%b, lui=%b, addm=%b",
                     alu_op, writeenable, rd_src, alu_src2, except, control_type, mem_read, word_we, byte_we, byte_load, slt, lui, addm);


        // Test BEQ instruction (I-type, zero flag = 0)
        opcode = `OP_BEQ; zero = 0;
        #10 $display("Test BEQ not taken: alu_op=%b, writeenable=%b, rd_src=%b, alu_src2=%b, except=%b, control_type=%b, mem_read=%b, word_we=%b, byte_we=%b, byte_load=%b, slt=%b, lui=%b, addm=%b",
                     alu_op, writeenable, rd_src, alu_src2, except, control_type, mem_read, word_we, byte_we, byte_load, slt, lui, addm);

        // Test BEQ instruction (I-type, zero flag = 1)
        opcode = `OP_BEQ; zero = 1;
        #10 $display("Test BEQ taken: alu_op=%b, writeenable=%b, rd_src=%b, alu_src2=%b, except=%b, control_type=%b, mem_read=%b, word_we=%b, byte_we=%b, byte_load=%b, slt=%b, lui=%b, addm=%b",
                     alu_op, writeenable, rd_src, alu_src2, except, control_type, mem_read, word_we, byte_we, byte_load, slt, lui, addm);

        // Test BNE instruction (I-type, zero flag = 0)
        opcode = `OP_BNE; zero = 0;
        #10 $display("Test BNE taken: alu_op=%b, writeenable=%b, rd_src=%b, alu_src2=%b, except=%b, control_type=%b, mem_read=%b, word_we=%b, byte_we=%b, byte_load=%b, slt=%b, lui=%b, addm=%b",
                     alu_op, writeenable, rd_src, alu_src2, except, control_type, mem_read, word_we, byte_we, byte_load, slt, lui, addm);

        // Test BNE instruction (I-type, zero flag = 1)
        opcode = `OP_BNE; zero = 1;
        #10 $display("Test BNE not taken: alu_op=%b, writeenable=%b, rd_src=%b, alu_src2=%b, except=%b, control_type=%b, mem_read=%b, word_we=%b, byte_we=%b, byte_load=%b, slt=%b, lui=%b, addm=%b",
                     alu_op, writeenable, rd_src, alu_src2, except, control_type, mem_read, word_we, byte_we, byte_load, slt, lui, addm);

        // Test LW instruction (I-type)
        opcode = `OP_LW;
        #10 $display("Test LW: alu_op=%b, writeenable=%b, rd_src=%b, alu_src2=%b, except=%b, control_type=%b, mem_read=%b, word_we=%b, byte_we=%b, byte_load=%b, slt=%b, lui=%b, addm=%b",
                     alu_op, writeenable, rd_src, alu_src2, except, control_type, mem_read, word_we, byte_we, byte_load, slt, lui, addm);

        // Test SW instruction (I-type)
        opcode = `OP_SW;
        #10 $display("Test SW: alu_op=%b, writeenable=%b, rd_src=%b, alu_src2=%b, except=%b, control_type=%b, mem_read=%b, word_we=%b, byte_we=%b, byte_load=%b, slt=%b, lui=%b, addm=%b",
                     alu_op, writeenable, rd_src, alu_src2, except, control_type, mem_read, word_we, byte_we, byte_load, slt, lui, addm);

       
        // Test LUI instruction (I-type)
        opcode = `OP_LUI;
        #10 $display("Test LUI: alu_op=%b, writeenable=%b, rd_src=%b, alu_src2=%b, except=%b, control_type=%b, mem_read=%b, word_we=%b, byte_we=%b, byte_load=%b, slt=%b, lui=%b, addm=%b",
                     alu_op, writeenable, rd_src, alu_src2, except, control_type, mem_read, word_we, byte_we, byte_load, slt, lui, addm);
*/
        // Test JR instruction (I-type)
        opcode = `OP_OTHER0; funct = `OP0_JR;
        #10 $display("Test JR: alu_op=%b, writeenable=%b, rd_src=%b, alu_src2=%b, except=%b, control_type=%b, mem_read=%b, word_we=%b, byte_we=%b, byte_load=%b, slt=%b, lui=%b, addm=%b",
                     alu_op, writeenable, rd_src, alu_src2, except, control_type, mem_read, word_we, byte_we, byte_load, slt, lui, addm);

                    
        opcode = `OP_SB;
        #10 $display("Test SB: alu_op=%b, writeenable=%b, rd_src=%b, alu_src2=%b, except=%b, control_type=%b, mem_read=%b, word_we=%b, byte_we=%b, byte_load=%b, slt=%b, lui=%b, addm=%b",
                     alu_op, writeenable, rd_src, alu_src2, except, control_type, mem_read, word_we, byte_we, byte_load, slt, lui, addm);

        opcode = `OP_LBU;
        #10 $display("Test LBU: alu_op=%b, writeenable=%b, rd_src=%b, alu_src2=%b, except=%b, control_type=%b, mem_read=%b, word_we=%b, byte_we=%b, byte_load=%b, slt=%b, lui=%b, addm=%b",
                    alu_op, writeenable, rd_src, alu_src2, except, control_type, mem_read, word_we, byte_we, byte_load, slt, lui, addm);

        // Finish simulation
        #10 $finish;
    end

    // Define signals for the decoder outputs
    wire [2:0] alu_op;
    wire [1:0] alu_src2;
    wire       writeenable, rd_src, except;
    wire [1:0] control_type;
    wire       mem_read, word_we, byte_we, byte_load, slt, lui, addm;
    
    // Instantiate the MIPS decoder
    mips_decode decoder(alu_op, writeenable, rd_src, alu_src2, except, control_type,
                        mem_read, word_we, byte_we, byte_load, slt, lui, addm,
                        opcode, funct, zero);
endmodule // decoder_test
