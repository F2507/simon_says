module decoder_2_4(
    input logic [1:0] led_in,
    output logic [3:0] led_out
);

    always @ (led_in) begin
        case(led_in)
            2'b00: led_out <= 4'b0001;
            2'b01: led_out <= 4'b0010;
            2'b10: led_out <= 4'b0100;
            2'b11: led_out <= 4'b1000;
            default: led_out <= 4'bxxxx;
        endcase
    end

endmodule