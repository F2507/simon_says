module input_block(    
    input logic clk,
    input logic reset,
    input logic on_off,            
    input logic [9:0] sw,

    output logic [9:0] led,  
    output logic [3:0] to_cmp
);

reg [3:0 ]save_sw;


always @ (posedge  clk && reset == 1) begin
    // when you flip the switch it saves the input
    if(on_off == 1 && sw != 10'd0)begin
        save_sw <= sw;
        led <= sw;

    // when you flip the switch back it sends the input
    end else if(on_off == 1 && sw == 10'd0) begin
        led <= sw;
        to_cmp <= sw[3:0];
    
    end else begin 
        led <= 10'b0000_0000_00;
        to_cmp <= 4'bxxxx;
    end

end



endmodule