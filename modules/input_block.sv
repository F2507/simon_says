module input_block(    
    input logic clk,
    input logic reset,
    input logic on_off,            
    input logic [9:0] sw,

    output logic [9:0] led,  
    output logic [3:0] to_cmp,
    output logic input_done
);

reg [3:0]save_sw;


always_ff @ (posedge clk & reset == 1) begin
    if(on_off == 1)begin
        
        if(sw != 10'd0)begin
            save_sw <= sw[3:0];
            led <= sw;
            input_done <= 0;

        end else if (sw == 10'd0 && save_sw != 4'd0) begin
            to_cmp <= save_sw;
            led <= sw;
            input_done <= 1;

        end else 
            input_done <= 0;



    end else begin
        input_done <= 0;
        save_sw <= 4'd0;
        led <= 10'b0000_0000_00;
        to_cmp <= 4'bxxxx;
    end

    // // when you flip the switch it saves the input
    // if(on_off == 1 && sw != 10'd0)begin
    //     save_sw <= sw[3:0];
    //     led <= sw;

    // // when you flip the switch back it sends the input
    // end else if(on_off == 1 && sw == 10'd0 && save_sw != 4'd0) begin
    //     to_cmp <= save_sw;
    //     led <= sw;
    
    // end else begin 
    //     save_sw <= 4'd0;
    //     led <= 10'b0000_0000_00;
    //     to_cmp <= 4'bxxxx;
    //     input_inProgress <= 0;
    // end

end



endmodule