module arith_machine_test;
    reg        clock = 0;
    always #5  clock = !clock;
    reg        reset = 1;
    reg        rd_src = 0, wr_enable = 0, NOT = 0;
    reg [1:0]  alu_src2 = 2'b0;
    reg [2:0]  alu_op = 3'b0;
    reg [15:0] imm16 = 16'h0;
    reg [4:0]  rs = 5'd0, rt = 5'd0, rd = 5'd0;

    integer i;

    reg done = 0; // Use to flag when simulation is done and print the register file contents

    arith_machine am(rs, rt, rd, rd_src, wr_enable, alu_src2, alu_op, imm16, NOT, clock, reset);

    initial begin
        $dumpfile("arith_machine.vcd");
        $dumpvars(0, arith_machine_test);
        for (i = 0 ; i < 32 ; i = i + 1)
            $dumpvars(1, am.rf.r[i]); // dump all register values

        # 3 reset = 0;
        for (i = 1 ; i < 32 ; i = i + 1)
            am.rf.r[i] = 100 + i; // Initialize all registers to  arbitrary values

        // try addi $1, $0, 0xaaa to fill a register, rd value does not matter
        # 2 rd_src = 1; wr_enable = 1; alu_src2 = 2'b01; alu_op = 3'b010; imm16 = 16'haaa; rs = 5'd0; rt = 5'd1; rd = 5'd0; NOT = 1;
         // try ori $5, $1, 0x0005 to fill another register, rd value does not matter
        # 10 rd_src = 1; wr_enable = 1;  alu_op = 3'b101; imm16 = 16'h5; rs = 5'd1; rt = 5'd5; rd = 5'd0; NOT = 1;
        // add more tests here!
      //# 2 wr_enable = 1; alu_src2 = 2'b01; alu_op = 3'b110; rd_src = 0; alu_src2 = 2'b00; NOT = 1; rs = 2; rd = 6;
        

        # 10 done = 1;
    end

    initial
        $monitor("At time %t, reset = %d rd_src = %b, w_en = %b, alu_src2 = %b, alu_op = %d, ",
                 $time, reset, rd_src, wr_enable, alu_src2, alu_op);
    // periodically check for the end of simulation.  When it happens
    // dump the register file contents.
    always @(negedge clock)
    begin
        if (done == 1'b1)
        begin
            $display ( "Dumping register state: " );
            $display ( "  Register :  hex-value (  dec-value )" );
            for (i = 0 ; i < 32 ; i = i + 1)
                $display ( "%d: 0x%x ( %d )", i, am.rf.r[i], am.rf.r[i]);
            $display ( "Done.  Simulation ending." );
            $finish;
        end
    end

endmodule // arith_machine_test