module fsm(
    input logic clk,
    input logic reset,
    input logic blinker_done,
    input logic cmp_good,

    output logic getRandNum,
    output logic rw_mem,
    output logic on_cmp,
    output logic on_input_block,
    output logic on_blinker,
    output logic [3:0] out_level
);

reg [3:0] level;    // The current level of the game
reg [3:0] step;     // This keeps track of the player's input
assign out_level = level;


typedef enum logic [2:0] {start, genRandNum, blink, acceptInput, win, defaultState} State;
State currState;

always @(posedge clk)begin
    if(reset == 1)  begin
        currState <= start;
        step <= 4'd0;
        level <= 4'd0;
    end else begin
    
        case(currState)

            start : begin 
                        currState <= genRandNum;
                        level <= level + 1;
                    end

            genRandNum: currState <= blink;

            blink : if (blinker_done) currState <= acceptInput;
                    else currState <= blink;

            acceptInput : if(cmp_good) begin
                                step <= step + 1;
                                if(step < level && level < 10) currState <= acceptInput;
                                else if (step == level && level < 10) currState <= genRandNum;
                                else if (step == level && level == 10) currState <= win;
                                
                            end else 
                                currState <= start;
            
            win: currState <= win;

            default : currState <= defaultState;

        endcase

        case (currState)
            start : {getRandNum, rw_mem, on_cmp, on_input_block, on_blinker} <= 5'b00000;

            genRandNum : {getRandNum, rw_mem, on_cmp, on_input_block, on_blinker} <= 5'b11000;

            blink : {getRandNum, rw_mem, on_cmp, on_input_block, on_blinker} <= 5'b00001;

            acceptInput : {getRandNum, rw_mem, on_cmp, on_input_block, on_blinker} <= 5'b00110;

            win : {getRandNum, rw_mem, on_cmp, on_input_block, on_blinker} <= 5'b00000;

            default : {getRandNum, rw_mem, on_cmp, on_input_block, on_blinker} <= 5'bxxxxx;

        endcase
    end
        
end
    

endmodule