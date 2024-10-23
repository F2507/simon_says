module tb_simonSays();

reg CLOCK_50; 
reg [3:0] KEY;
reg [9:0] SW; 
wire [9:0] LEDR;
wire [6:0] HEX0;


simonSays #(1) simonSays (.CLOCK_50(CLOCK_50), .KEY(KEY),
             .SW(SW), .LEDR(LEDR),
             .HEX0(HEX0));

typedef enum logic [2:0] {start, genRandNum, blink, acceptInput, validateInput, win, defaultState} State;

reg [1:0] memory_val;
reg [3:0] sw_input;
decoder_2_4 decoder_2_4(.led_in(memory_val), .led_out(sw_input));


initial forever begin 
    CLOCK_50 = 0; #5;
    CLOCK_50 = 1; #5;
    if(simonSays.fsm.currState == win) 
        $stop;
end

// Testing for correct input
initial forever begin
    #10;
    if (simonSays.fsm.currState == acceptInput) begin
        for (integer i = 0; i < 10; i = i + 1) begin
            $display("numbers[%0d] = %b", i, simonSays.mem.number_memory[i]);
                if(simonSays.mem.number_memory[i] <= 2'd3 )begin
                    // $display("YOLO"); #10;
                    memory_val = simonSays.mem.number_memory[i]; #10; 
                    // $display("memory_val= %b", memory_val);
                    SW = {6'b0000_00, sw_input}; #20; 
                    SW = 10'b0000_00_0000; #20; 
            end
        end
        $display("-------------------");
    end
end 

initial begin
    SW = 10'd0;
    #20;
    KEY = 4'd0;
    #20;
    KEY = 4'd1;
    // #560;

    // // Memory contents xx xx xx xx xx xx xx xx xx 10 
    // SW = 10'b0000_00_0100; #20; SW = 10'b0000_00_0000; // First input should be correct
    
    // // Memory contents xx xx xx xx xx xx xx xx 10 10 
    // #1200;
    // SW = 10'b0000_00_0100; #20; SW = 10'b0000_00_0000; #20 // First input should be correct
    // SW = 10'b0000_00_0100; #20; SW = 10'b0000_00_0000; #20 // Second input should be correct

    // #2000;
    
    // // Memory contents xx xx xx xx xx xx xx 00 10 10 
    // SW = 10'b0000_00_0100; #20; SW = 10'b0000_00_0000; #20 // First input should be correct
    // SW = 10'b0000_00_0100; #20; SW = 10'b0000_00_0000; #20 // Second input should be correct

    // // SW = 10'b0000_00_0100; #20; SW = 10'b0000_00_0000; #20 // Third input should be incorrect and reset back to start
    // SW = 10'b0000_00_0001; #20; SW = 10'b0000_00_0000; #20 // Third input should be correct 
    // #2800;

    // // Memory contents xx xx xx xx xx xx 00 00 10 10 
    // SW = 10'b0000_00_0100; #20; SW = 10'b0000_00_0000; #20 // First input should be correct
    // SW = 10'b0000_00_0100; #20; SW = 10'b0000_00_0000; #20 // Second input should be correct
    // SW = 10'b0000_00_0001; #20; SW = 10'b0000_00_0000; #20 // Third input should be correct 
    // SW = 10'b0000_00_0001; #20; SW = 10'b0000_00_0000; #20 // Fourth input should be correct 

    // #3500;
    // for (integer i = 0; i < 10; i = i + 1) begin
    //         $display("numbers[%0d] = %b", i, simonSays.mem.number_memory[i]);
    // end
    // $display("trying to display memory content");

    
    
    // $stop;

end

endmodule