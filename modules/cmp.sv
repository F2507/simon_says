module cmp(    
    input logic clk,
    input logic reset,
    input logic on_off,            
    input logic [3:0] sw,
    input logic [3:0] actual,

    output logic correct_input
);

always @ (posedge clk && reset == 1) begin
    if(on_off == 1) begin
        if(actual == sw)
            correct_input <= 1;
        else
            correct_input <= 0;
    end else
        correct_input <= 1'bx;


end

endmodule