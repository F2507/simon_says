module tb_mem_blinker();
reg clock; 
reg [3:0] address;
reg rw;
reg [1:0] in_num;
wire [1:0] out_num;

mem simple_memory (.clock(clock), .address(address), .rw(rw), .in_num(in_num), .out_num(out_num));

wire done_W;
wire [9:0] led_out;
reg on_off;
reg [3:0] hard_level = 4'd6;


blinker #(1) blinker(.clk(clock),
    .reset(1),
    .on_off(on_off),
    .level(hard_level),        // level is coiming from the fsm 
   .led_to_glow(out_num),  // led_to_glow is coming from simple_memory

    .done(done_W),              // done is going to the fsm to indicate that the module is done blinking 
    .count(address),        // count is going to simple_memory as the address to read from
    .led_out(led_out)      // led_out is going to the top level module
);




initial forever begin
    clock = 0; #5;
    clock = 1; #5;
    if(done_W == 1)
        on_off = 0;
end




initial begin
    on_off = 0; rw = 1;  #10;
    

    for (integer i = 0; i < 10; i++) begin
        address = i[3:0];
        in_num = i[1:0];
        #10;
    end

    #100;

    rw = 0; on_off = 1; #10;

    for (integer i = 0; i < 10; i++) begin
        address = i[3:0];
        #500;
    end


    $stop;
end


endmodule