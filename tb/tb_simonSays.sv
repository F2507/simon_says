module tb_simonSays();

reg CLOCK_50; 
reg [3:0] KEY;
reg [9:0] SW; 
wire [9:0] LEDR;
wire [6:0] HEX0;


simonSays #(1) simonSays (.CLOCK_50(CLOCK_50), .KEY(KEY),
             .SW(SW), .LEDR(LEDR),
             .HEX0(HEX0));

initial forever begin
    CLOCK_50 = 0; #5;
    CLOCK_50 = 1; #5;

end 

initial begin
    #20;
    KEY[0] = 1;
    #1000;
    $stop;

end

endmodule