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


initial forever begin
    CLOCK_50 = 0; #5;
    CLOCK_50 = 1; #5;
    // if (simonSays.fsm.currState == acceptInput)
    //     $stop;

end 

initial begin
    SW = 10'd0;
    #20;
    KEY = 4'd0;
    #20;
    KEY = 4'd1;
    #560;

    // Memory contents xx xx xx xx xx xx xx xx xx 10 
    SW = 10'b0000_00_0100; #20; SW = 10'b0000_00_0000; // First input should be correct
    
    // Memory contents xx xx xx xx xx xx xx xx 10 10 
    #1200;
    SW = 10'b0000_00_0100; #20; SW = 10'b0000_00_0000; #20 // First input should be correct
    SW = 10'b0000_00_0100; #20; SW = 10'b0000_00_0000; #20 // Second input should be correct

    #2000;
    
    // Memory contents xx xx xx xx xx xx xx 00 10 10 
    SW = 10'b0000_00_0100; #20; SW = 10'b0000_00_0000; #20 // First input should be correct
    SW = 10'b0000_00_0100; #20; SW = 10'b0000_00_0000; #20 // Second input should be correct

    // SW = 10'b0000_00_0100; #20; SW = 10'b0000_00_0000; #20 // Third input should be incorrect and reset back to start
    SW = 10'b0000_00_0001; #20; SW = 10'b0000_00_0000; #20 // Third input should be correct 
    #2800;

    // Memory contents xx xx xx xx xx xx 00 00 10 10 
    SW = 10'b0000_00_0100; #20; SW = 10'b0000_00_0000; #20 // First input should be correct
    SW = 10'b0000_00_0100; #20; SW = 10'b0000_00_0000; #20 // Second input should be correct
    SW = 10'b0000_00_0001; #20; SW = 10'b0000_00_0000; #20 // Third input should be correct 
    SW = 10'b0000_00_0001; #20; SW = 10'b0000_00_0000; #20 // Fourth input should be correct 

    #3600;

    
    
    
    $stop;

end

endmodule