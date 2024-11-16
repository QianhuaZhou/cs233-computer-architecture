
module pipelined_adding_machine(out, clk, reset);
input         clk, reset;
output [31:0] out;
wire   [31:2] index, next_index;
wire   [31:0] data, data_2, out_temp;

// DO NOT comment out or rename this module
// or the test bench will break
register #(30, 30'd0) Counter(index, next_index, clk, /* enable */1'b1, reset);
adder30 Adder(next_index, index, 30'h1);

register #(32, 32'd0) pipeline(data_2, data, clk, 1'b1, reset);

adding_machine_memory rom(data, index);
alu32 alu(out_temp, , `ALU_ADD, out, data_2);

register #(32, 32'd0) Register(out, out_temp, clk, /* enable */1'b1, reset);

endmodule // pipelined_machine