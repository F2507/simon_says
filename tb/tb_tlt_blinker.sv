module tb_tlt_blinker();

reg tb_clk;
reg [3:0] key ;
wire [9:0] led ;
wire [6:0] hex ;

tlt_blinker #( 4'd6,  2'd1, 1)
            tlt_blinker (.CLOCK_50(tb_clk), .KEY(key), .LEDR(led), .HEX0(hex));

initial forever begin
    tb_clk = 0; #4;
    tb_clk = 1; #4;
end



initial begin
    #20;
    key = 4'b0001; //reset
    #10;
    key = 4'b0011; 
    #1000
    key = 4'b0001; 
    #100
    key = 4'b0011; 
    #1000    
    $stop;


end


endmodule