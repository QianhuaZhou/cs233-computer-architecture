module comparator8_test;

  reg [7:0] A = 0, B = 0; // start by comparing 0 and 0
  
  wire P, Q;
  comparator8 c8(P, Q, A, B);
  
   initial begin
    $dumpfile("commparator8_test.vcd");
    $dumpvars(0, comparator8_test);
/* 
    // Example test case
    # 4 A=8'h02; B = 8'h02; // compare 2 and 2

    // ADD MORE OF YOUR OWN TEST CASES TO FULLY DEBUG THE CIRCUIT
    // Test Case 1: A = B
    #4 A = 8'b11111111; B = 8'b11111111; // compare 255 and 255 (A = B)

    // Test Case 2: A > B
    #4 A = 8'b10101010; B = 8'b01010101; // compare 170 and 85 (A > B)

    // Test Case 3: A < B
    #4 A = 8'b00110011; B = 8'b01110111; // compare 51 and 119 (A < B)

    // Edge Case 1: A = 0, B = 0
    #4 A = 8'b00000000; B = 8'b00000000; // compare 0 and 0 (A = B)

    // Edge Case 2: A = 255, B = 0
    #4 A = 8'b11111111; B = 8'b00000000; // compare 255 and 0 (A > B)

    // Edge Case 3: A = 0, B = 255
    #4 A = 8'b00000000; B = 8'b11111111; // compare 0 and 255 (A < B)

    // Random Test Case 1: A > B
    #4 A = 8'b01011010; B = 8'b00111100; // compare 90 and 60 (A > B)

    // Random Test Case 2: A < B
    #4 A = 8'b10000001; B = 8'b10000010; // compare 129 and 130 (A < B)
*/
      //previous failed case
      #4 A = 8'h00; B = 8'h00;
      #4 A = 8'h02; B = 8'h02;
      #4 A = 8'haa; B = 8'haa;
      #4 A = 8'haa; B = 8'h55;
      #4 A = 8'h55; B = 8'haa;
      #4 A = 8'hf0; B = 8'h0f;
      #4 A = 8'h0f; B = 8'hf0;
      #4 A = 8'h01; B = 8'h00;
      #4 A = 8'h00; B = 8'h01;

      #4;
      $finish;
    end

    initial
      $monitor("A = %b B = %b PQ = %b%b", A, B, P, Q);

endmodule // comparator8_test
