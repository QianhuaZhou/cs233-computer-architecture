module sc_block(s, c, a, b);
  output  s, c;
  input   a, b;
  wire    w1, w2, not_a, not_b;
  // the "c" output is just the AND of the two inputs
  and a1(c, a, b);
  // the "s" output is 1 only when exactly one of the inputs is 1
  not n1(not_a, a);
  not n2(not_b, b);
  and a2(w1, a, not_b);
  and a3(w2, b, not_a);
  or  o1(s, w1, w2);
endmodule // sc_block

// Implement sc2_block in Verilog as shown in the specification
// Use multiple instances of sc_block in sc_block2
module sc2_block(S, Cout, A, B, Cin);
  output  S, Cout;
  input   A, B, Cin;

  // ADD YOUR CODE HERE
  wire s1_out, c1_out, c2_out;
  sc_block block1(s1_out, c1_out, A, B);
  sc_block block2(S, c2_out, s1_out, Cin);
  or o2(Cout, c2_out, c1_out);



endmodule // sc2_block
