module arith_machine(rs, rt, rd, rd_src, wr_enable, alu_src2, alu_op, imm16, NOT, clock, reset);
    input        rd_src, wr_enable;
    input [1:0]  alu_src2;
    input [2:0]  alu_op;
    input [15:0] imm16;
    input [4:0]  rs, rt, rd;
    input        clock, reset;
    input NOT;

    wire [31:0]  sextimm, zextimm;

    wire [4:0]   w_addr;

    // sign-extended immediate
    assign sextimm = { {16{imm16[15]}}, imm16[15:0] };

    // zero-extended immediate
    assign zextimm = { {16{1'b0}}, imm16[15:0] };

    wire [31:0]  Rrs, Rrt, B_data;
    wire [31:0]  w_data, alu_result;
    
    mux2v #(5) rd_mux(w_addr, rd, rt, rd_src);
    //assign not_result = ~Rrs;
    //assign w_data = (NOT) ? not_result : alu_result;

    regfile rf (Rrs, Rrt,
                rs, rt, w_addr, w_data,
                wr_enable, clock, reset);
    
    mux3v alu_src2_mux(B_data, Rrt, sextimm, zextimm, alu_src2);

    alu32 alu(alu_result, Rrs, B_data, alu_op);
    
    mux2v m(w_data, alu_result, ~Rrs, NOT);
    
    /*
    always @(posedge clock) begin
        if (wr_enable) begin
            $display("At time %0t: w_addr = %h, w_data = %h, rs = %d, rt = %d", 
                     $time, w_addr, w_data, rs, rt);
        end
    end
    */
    
endmodule // arith_machine


module muxNOT(w_data, alu_result, Rrs, NOT);
    output [31:0] w_data, alu_result, Rrs;
    input   NOT;
    assign w_data = (NOT) ? ~Rrs : alu_result;
    //assign w_data = (alu_result & (~NOT)) | (NOT & (~Rrs));

endmodule
