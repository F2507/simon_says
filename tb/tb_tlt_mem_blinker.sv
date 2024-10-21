module tb_tlt_mem_blinker(); 

reg CLOCK_50;
reg [3:0] KEY;
wire [9:0] LEDR; 
wire [6:0] HEX0;


tlt_mem_blinker #( 4'd5,  1) tlt_mem_blinker 
(.CLOCK_50(CLOCK_50), .KEY(KEY),  .LEDR(LEDR), .HEX0(HEX0));

initial forever begin
    CLOCK_50 = 0; #5;
    CLOCK_50 = 1; #5;
    if (tlt_mem_blinker.blinker.done == 1) begin
        #20;
        $stop;
    end
    
end


initial  begin
    KEY[0] = 1;

    // #9000;
    // $stop;
end




 endmodule