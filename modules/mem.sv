// rw: 0 - read,  1 - write
// address: range 0 -> 10 (inclusive)
// in_num / out_num : 0,1,2,3

module mem(input logic clock, input logic [3:0] address, input logic rw, input logic [1:0] in_num, output logic [1:0] out_num);

// 2-bit, depth = 16
reg [1:0] number_memory [9:0];

always_ff @(posedge clock) begin
    // read
    if(rw == 0)
        out_num <= number_memory[address];

    // write
    else if(rw) 
        number_memory[address] <= in_num;
end

endmodule