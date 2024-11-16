module timer(TimerInterrupt, cycle, TimerAddress,
             data, address, MemRead, MemWrite, clock, reset);
    output        TimerInterrupt;
    output [31:0] cycle;
    output        TimerAddress;
    input  [31:0] data, address;
    input         MemRead, MemWrite, clock, reset;

    // complete the timer circuit here

    // HINT: make your interrupt cycle register reset to 32'hffffffff
    //       (using the reset_value parameter)
    //       to prevent an interrupt being raised the very first cycle
    wire[31:0] cycle_counter_out, alu_out, interrupt_cycle_out;
    wire TimerWrite, interrupt_line_enable, TimerRead, timeaddress_jude, acknowledge_jude, Acknowledge, interrupt_line_reset;

    register cycle_counter(cycle_counter_out, alu_out, clock, 1'd1, reset);
    alu32 alu_add(alu_out, , ,`ALU_ADD, cycle_counter_out, 32'd1);
    register #(32, 32'hffffffff) interrupt_cycle(interrupt_cycle_out, data, clock, TimerWrite, reset);
    assign interrupt_line_enable = cycle_counter_out == interrupt_cycle_out;//>??
 
    //tristate tri(cycle, cycle_counter_out, TimerRead);
    tristate #(32) tristate_cycle(cycle, cycle_counter_out, TimerRead);

    //assign cycle = (TimerRead) ? cycle_counter_out : 1'bz;
    assign timeaddress_jude = address == 32'hffff001c;
    assign acknowledge_jude = address == 32'hffff006c;
    assign TimerAddress = timeaddress_jude | acknowledge_jude;
    assign Acknowledge = acknowledge_jude & MemWrite;

    assign TimerRead = MemRead & timeaddress_jude;
    assign TimerWrite = MemWrite & timeaddress_jude;

    assign interrupt_line_reset = Acknowledge | reset;
    dffe interrupt_line(TimerInterrupt, 1'd1, clock, interrupt_line_enable, interrupt_line_reset);
endmodule