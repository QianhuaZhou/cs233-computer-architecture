module test;

   // these are inputs to "circuit under test"
   reg  a, b, c, d;

   // wires for the outputs of "circuit under test"
   wire out;
  
   // the circuit under test
   sop_circuit sop1(out, a, b, c, d);  
    
   initial begin               // initial = run at beginning of simulation
                               // begin/end = associate block with initial
      
      $dumpfile("test.vcd");  // name of dump file to create
      $dumpvars(0, test);     // record all signals of module "test" and sub-modules
                              // remember to change "test" to the correct
                              // module name when writing your own test benches

      // test all input combinations
      a = 0; b = 0; c = 0; d = 0; #10;
      a = 0; b = 0; c = 0; d = 1; #10;
      a = 0; b = 0; c = 1; d = 0; #10;
      a = 0; b = 0; c = 1; d = 1; #10;
      a = 0; b = 1; c = 0; d = 0; #10;
      a = 0; b = 1; c = 0; d = 1; #10;
      a = 0; b = 1; c = 1; d = 0; #10;
      a = 0; b = 1; c = 1; d = 1; #10;
      a = 1; b = 0; c = 0; d = 0; #10;
      a = 1; b = 0; c = 0; d = 1; #10;
      a = 1; b = 0; c = 1; d = 0; #10;
      a = 1; b = 0; c = 1; d = 1; #10;
      a = 1; b = 1; c = 0; d = 0; #10;
      a = 1; b = 1; c = 0; d = 1; #10;
      a = 1; b = 1; c = 1; d = 0; #10;
      a = 1; b = 1; c = 1; d = 1; #10;
      
      $finish;        // end the simulation
   end                      
   
   initial begin
     $display("inputs = in  outputs = out");
     $monitor("abcd = %b%b%b%b outputs = %b   time = %2t",
              a, b, c, d, out, $time);
   end
endmodule // test
