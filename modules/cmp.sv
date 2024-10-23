module cmp(    
    input logic clk,
    input logic reset,
    input logic on_off,            
    input logic [3:0] sw,
    input logic [1:0] actual,

    output logic correct_input
);

wire [3:0] actual_4bit;

decoder_2_4 decoder_2_4(.led_in(actual), .led_out(actual_4bit));

assign correct_input = (on_off == 1) ? (actual_4bit == sw ? 1 : 0) : 1'bx;


endmodule