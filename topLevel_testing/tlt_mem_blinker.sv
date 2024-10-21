module tlt_mem_blinker #( parameter hard_level = 4'd5,   parameter ms=1_000_000)
(input logic CLOCK_50, input logic [3:0] KEY, output logic [9:0] LEDR, output logic [6:0] HEX0);

reg [3:0] address;
reg [3:0] count;

wire [1:0] out_num;
reg rw = 1;
reg on_off = 0;

reg [1:0] values;
integer i = 0;

// Write into memory 
always @ (posedge CLOCK_50 && KEY[0] == 1 ) begin 
    if (i < 32'd10) begin
        address <= i[3:0];
        values <= i[1:0];
        i <= i+1;
    end else begin
        address <= count;
        values <= 2'b00;
        rw <= 0;
        on_off <= 1;

    end

    

end

mem mem(.clock(CLOCK_50), .address(address), .rw(rw), .in_num(values), .out_num(out_num));

blinker #(ms) blinker(.clk(CLOCK_50),
    .reset(KEY[0]),
    .on_off(on_off),
    .level(hard_level),        // level is coiming from the fsm 
   .led_to_glow(out_num),  // led_to_glow is coming from simple_memory

    .done(done_W),              // done is going to the fsm to indicate that the module is done blinking 
    .count(count),        // count is going to simple_memory as the address to read from
    .led_out(LEDR)      // led_out is going to the top level module
);


endmodule