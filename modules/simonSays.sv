module simonSays #( parameter ms=1_000_000) (input logic CLOCK_50, input logic [3:0] KEY,
             input logic [9:0] SW, output logic [9:0] LEDR,
             output logic [6:0] HEX0);

// KEY[0] = RESET
wire [1:0] newRandNum;
wire [1:0] mem_out_num;
wire [3:0] to_cmp;

wire [3:0] mem_address;
wire [3:0] address_from_blinker;
wire [3:0] address_from_fsm;


wire getRandNum;
wire rw_mem;
wire on_cmp;
wire on_input_block;
wire on_blinker;
wire cmp_good;
wire blinker_done;

wire [9:0] ledr_blinker;
wire [9:0] ledr_input_block;

assign LEDR = on_blinker ? ledr_blinker : 
(on_input_block ? ledr_input_block : 10'b0000_0000_00);

assign mem_address = on_blinker ? address_from_blinker : address_from_fsm;


rng rng(.clock(CLOCK_50), .reset(KEY[0]), .new_num(newRandNum));

mem mem(.clock(CLOCK_50), .address(mem_address), .rw(rw_mem), .in_num(newRandNum), .out_num(mem_out_num));

blinker #(ms)
blinker(
    .clk(CLOCK_50),
    .reset(KEY[0]),
    .on_off(on_blinker),             
    .level(address_from_fsm),       
    .led_to_glow(mem_out_num),  

    .done(blinker_done),              
    .count(address_from_blinker),        
    .led_out(ledr_blinker)    
);

input_block input_block(    
    .clk(CLOCK_50),
    .reset(KEY[0]),
    .on_off(on_input_block),            
    .sw(SW),

    .led(ledr_input_block),  
    .to_cmp(to_cmp)
);

cmp cmp(    
    .clk(CLOCK_50),
    .reset(KEY[0]),
    .on_off(on_cmp),            
    .sw(to_cmp),
    .actual(mem_out_num),
    .correct_input(cmp_good)
);

fsm fsm(    
    .clk(CLOCK_50),
    .reset(KEY[0]),
    .blinker_done(blinker_done),
    .cmp_good(cmp_good),

    .getRandNum(getRandNum),
    .rw_mem(rw_mem),
    .on_cmp(on_cmp),
    .on_input_block(on_input_block),
    .on_blinker(on_blinker),
    .out_level(address_from_fsm)
);


endmodule