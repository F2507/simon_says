module input_block(    
    input logic clk,
    input logic reset,
    input logic on_off,            
    input logic [9:0] sw,

    output logic [9:0] led,  
    output logic [3:0] to_cmp,
    output logic input_done
);

reg [3:0]save_sw = 4'd0;
reg extraClockCount = 0;

// assign input_done = on_off ? (sw != 10'd0 ? 0 : (sw == 10'd0 && save_sw != 4'd0 ? 1 : 0)) : 0;
assign led = sw;
reg [9:0] debounce_counter = 10'd0;

always @ (posedge clk && reset == 1) begin
    if(on_off == 1)begin
        
        if(sw == 10'd0)begin
            if(save_sw != 4'd0 ) begin
                debounce_counter <= debounce_counter + 1;
                if(debounce_counter == 10'd1023) begin
                    to_cmp <= save_sw;
                    input_done <= 1;
                    save_sw <= 4'd0;
                    debounce_counter <= 10'd0;
                end

            end else begin
                input_done <= 0;
                debounce_counter <= 10'd0;
            end

        end else begin
            save_sw <= sw[3:0];
            input_done <= 0;
            debounce_counter <= 10'd0;

        end


    

    end else begin
        input_done <= 0;
        save_sw <= 4'd0;
        to_cmp <= 4'bxxxx;
        debounce_counter <= 10'd0;
        
    end


end



endmodule