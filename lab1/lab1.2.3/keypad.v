module keypad(valid, number, a, b, c, d, e, f, g);
   output   valid;
   output [3:0] number;
   input  a, b, c, d, e, f, g;

   assign valid = ~(((~a)&(~b)&(~c)&(~d)&(~e)&(~f)&(~g))| ((~a)&(~b)&c&(~d)&(~e)&(~f)&g)| (a&(~b)&(~c)&(~d)&(~e)&(~f)&g));
   assign number[3] = ((~a)&(~b)&c&(~d)&(~e)&f&(~g))|( (~a)&b&(~c)&(~d)&(~e)&f&(~g));
   assign number[2] = ((~a)&(~b)&c&(~d)&e&(~f)&(~g))|( (~a)&b&(~c)&(~d)&e&(~f)&(~g) )|( a&(~b)&(~c)&(~d)&(~e)&f&(~g) )|( a&(~b)&(~c)&(~d)&e&(~f)&(~g));
   assign number[1] = ((~a)&(~b)&c&(~d)&e&(~f)&(~g))|( (~a)&(~b)&c&d&(~e)&(~f)&(~g))|((~a)&b&(~c)&d&(~e)&(~f)&(~g))|(a&(~b)&(~c)&(~d)&(~e)&f&(~g));
   assign number[0] = ((~a)&(~b)&c&(~d)&(~e)&f&(~g))|( (~a)&(~b)&c&d&(~e)&(~f)&(~g)  )|( (~a)&b&(~c)&(~d)&e&(~f)&(~g) )|( a&(~b)&(~c)&(~d)&(~e)&f&(~g)  )|( a&(~b)&(~c)&d&(~e)&(~f)&(~g));

endmodule // keypad
