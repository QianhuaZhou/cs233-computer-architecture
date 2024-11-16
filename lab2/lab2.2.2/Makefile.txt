CXX = clang++
CPPFLAGS = -Wall -g

comparator1_deps = comparator1.v comparator1_tb.v
comparator8_deps = comparator1.v comparator8.v comparator8_tb.v

BENCHES = comparator1 comparator8 
.PHONY: all $(BENCHES) clean
.SECONDEXPANSION:

$(BENCHES): %: %_exe
	./$<

%_exe: $$(%_deps)
	iverilog -o $@ -Wall $^

clean:
	rm -rf *_exe *.vcd *.dSYM
