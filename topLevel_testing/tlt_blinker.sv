module tlt_blinker #( parameter hard_level = 4'd5,  parameter hard_led_to_glow = 2'd2, parameter ms=1_000_000)
(input logic CLOCK_50, input logic [3:0] KEY, output logic [9:0] LEDR, output logic [6:0] HEX0);

    // parameter  hard_level = 4'd5;
    // parameter hard_led_to_glow = 2'd2;
    wire [3:0] countWire ;
    wire done_W;



blinker #(ms) blinker(.clk(CLOCK_50),
    .reset(KEY[0]),
    .on_off(KEY[1]),
    .level(hard_level),        // level is coiming from the fsm 
   .led_to_glow(hard_led_to_glow),  // led_to_glow is coming from simple_memory

    .done(done_W),              // done is going to the fsm to indicate that the module is done blinking 
    .count(countWire),        // count is going to simple_memory as the address to read from
    .led_out(LEDR)      // led_out is going to the top level module
);


sevenSeg  sevenSeg(.counter(countWire),  .hex(HEX0));


endmodule