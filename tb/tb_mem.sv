module tb_mem();
reg clock; 
reg [3:0] address;
reg rw;
reg [1:0] in_num;
wire [1:0] out_num;

mem simple_memory (.clock(clock), .address(address), .rw(rw), .in_num(in_num), .out_num(out_num));

initial forever begin
    clock = 0; #4;
    clock = 1; #4;
end


initial begin
    rw = 1;  #10;

    for (integer i = 0; i < 10; i++) begin
        address = i[3:0];
        in_num = i[1:0];
        #10;
    end

    #100;

    rw = 0;  #10;
    for (integer i = 0; i < 10; i++) begin
        address = i[3:0];
        #10;
    end


    $stop;

end


endmodule
