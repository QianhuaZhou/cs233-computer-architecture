
module chopUpDigits_control (done, get_new, load_index, load_number, select_base, write, base, number_is_0, go, clk, reset);
	output done, get_new, load_index, load_number, select_base, write;
	input base, number_is_0, go;
	input clk, reset;
	
	wire sGarbage, sStart, swhile8, swrite8, swhile16, swrite16, sdone;
	
	wire sGarbage_next = reset | (sGarbage & ~go);
	wire sStart_next =  ~reset & ((sGarbage & go) | (sStart & go) | (sdone & go));
	wire swhile8_next = ~reset & (swrite8 | (sStart & ~go & ~base));
	wire swrite8_next = ~reset & swhile8 & ~number_is_0;
	wire swhile16_next = ~reset & ((sStart & ~go & base) | swrite16);
	wire swrite16_next = ~reset & swhile16 & ~number_is_0;
	wire sdone_next = ~reset & ((swhile16 & number_is_0) | (swhile8 & number_is_0)| (sdone & ~go));
	
	dffe d1(sGarbage, sGarbage_next, clk, 1'b1, 1'b0);
	dffe d2(sStart, sStart_next, clk, 1'b1, 1'b0);
	dffe d3(swhile8, swhile8_next, clk, 1'b1, 1'b0);
	dffe d4(swrite8, swrite8_next, clk, 1'b1, 1'b0);
	dffe d5(swhile16, swhile16_next, clk, 1'b1, 1'b0);
	dffe d6(swrite16, swrite16_next, clk, 1'b1, 1'b0);
	dffe d7(sdone, sdone_next, clk, 1'b1, 1'b0);
	
	assign done = sdone;
	assign get_new = sStart;
	assign load_index = sStart | swrite8 | swrite16;
	assign load_number = sStart | swrite8 | swrite16;
	assign select_base = swrite16;
	assign write = swrite8 | swrite16;

endmodule
