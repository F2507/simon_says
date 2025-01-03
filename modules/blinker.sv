module blinker
// This parametr is set to 1*10^6 by default because the clock is 50 MGHz
// but for test benches it is set to 1
#( parameter ms=1_000_000)
(
    input logic clk,
    input logic reset,
    input logic on_off,             // on_off is coiming from the fsm 
    input logic [3:0] level,        // level is coiming from the fsm 
    input logic [1:0] led_to_glow,  // led_to_glow is coming from simple_memory

    output logic done,              // done is going to the fsm to indicate that the module is done blinking 
    output logic [3:0] count,        // count is going to simple_memory as the address to read from
    output logic [9:0] led_out      // led_out is going to the top level module
);


// if level <= 4'd10 then don't glow 

// This keeps track of the current step for the blinking
// and acts as an address for fetching the next led to glow
// from the memory
initial count = 4'd0; 

integer time_counter = 1;
initial done = 1'd0;
wire [3:0] led_out_decoder;

// takes 2 bit binary inout and outputs its 4-bit one hot encoding
decoder_2_4 decoder_2_4(.led_in(led_to_glow), .led_out(led_out_decoder));

//The clock is 50MHz, meaning that every 50 * 10 ^ 6 cycles we get  one second
always @ (posedge clk && reset == 1 ) begin

    if(level >= 0 && level <= 4'd10  && on_off == 1)begin

        // At half a second glow the correct led
        if(time_counter == 25*ms ) begin
            led_out <= {6'd0, led_out_decoder};
            count <= count + 1;
            time_counter <= time_counter + 1;
            
        // Turn off the led half a second later
        end else if(time_counter == 50*ms) begin
            led_out <= 10'd0;
            time_counter <= 1;

            // If we caguht up to the current level then this process is done
            if (count == level) begin
                done <= 1;
            end


        end else if(on_off == 1)
            time_counter <= time_counter + 1;


    // if level > 4'd10 reset 
    end else begin
        time_counter = 1;
        count <= 4'd0;
        done <= 0;
        led_out <= 10'b0000_0000_00;
    end
end

endmodule