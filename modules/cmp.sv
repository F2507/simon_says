// The compare block
module cmp(    
    input logic clk,
    input logic reset,
    input logic on_off,            
    input logic [3:0] sw,       // Input from the switches coming from the 'input block'
    input logic [1:0] actual,   // Actual value from memory 

    output logic correct_input  // 1 if they are equal, 0 otherwise
);

wire [3:0] actual_4bit;

decoder_2_4 decoder_2_4(.led_in(actual), .led_out(actual_4bit));

assign correct_input = (on_off == 1) ? (actual_4bit == sw ? 1 : 0) : 1'bx;


endmodule