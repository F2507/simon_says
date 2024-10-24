module fsm(
    input logic clk,
    input logic reset,
    input logic blinker_done,
    input logic cmp_good,
    input logic input_done,

    output logic getRandNum,
    output logic rw_mem,
    output logic on_cmp,
    output logic on_input_block,
    output logic on_blinker,
    output logic [3:0] out_level,
    output logic [3:0] sevenSegDisplay
);

reg [3:0] level;    // The current level of the game
reg [3:0] step;     // This keeps track of the player's input


typedef enum logic [2:0] {start, genRandNum, blink, acceptInput, validateInput, win, defaultState} State;
State currState;

always_ff @(posedge clk)begin
    if(reset == 0)  begin
        currState <= start;
        step <= 4'd0;
        
    end else begin
    
        case(currState)

            start :  begin
                currState <= genRandNum; 
                level <= 4'd0;
                step <= 0;
            end

            genRandNum: begin
                currState <= blink;
                level <= level + 1'b1;
                step <= 0;
            end

            blink : if (blinker_done) currState <= acceptInput;
                    else currState <= blink;

            acceptInput :   if(input_done) begin
                                currState <= validateInput;
                                step <= step + 1;
                            end else currState <= acceptInput;

            // If the use input was correct 
            validateInput : if(cmp_good) begin
                                // Check if it is the final input if not, accept another input
                                if(step < level && level <= 4'd10) currState <= acceptInput;

                                // If it is the final input check if we have reached the final level
                                // if not generate a new random number and go the next level
                                else if (step == level && level < 4'd10) currState <= genRandNum;

                                // if this is the final input and the final level, the player wins
                                else if (step == level && level == 4'd10) currState <= win;  
                                
                            end else
                                // If you make a mistake, start over
                                currState <= start;
            
            win: currState <= win;

            default : begin
                currState <= defaultState;
                level <= 4'd0;
            end

        endcase

    end     
end

    always_comb  begin 
        case (currState)
            start : begin
                {getRandNum, rw_mem, on_cmp, on_input_block, on_blinker} <= 5'b00000;
                sevenSegDisplay <= 4'b0000;
                out_level <= 4'bxxxx;
            end

            genRandNum : begin
                {getRandNum, rw_mem, on_cmp, on_input_block, on_blinker} <= 5'b11000;
                sevenSegDisplay <= 4'b0000;
                out_level <= level;
                
            end

            blink : begin 
                {getRandNum, rw_mem, on_cmp, on_input_block, on_blinker} <= 5'b00001;
                sevenSegDisplay <= 4'b0000;
                out_level <= level;
            end

            acceptInput : begin
                {getRandNum, rw_mem, on_cmp, on_input_block, on_blinker} <= 5'b00010;
                sevenSegDisplay <= 4'b0001;
                out_level <= step;
            end

            validateInput : begin 
                {getRandNum, rw_mem, on_cmp, on_input_block, on_blinker} <= 5'b00100;
                sevenSegDisplay <= 4'b0000;
                out_level <= step;
            end

            win : begin 
                {getRandNum, rw_mem, on_cmp, on_input_block, on_blinker} <= 5'b00000;
                sevenSegDisplay <= 4'b1001;
                out_level <= 4'bxxxx;
            end

            default : begin
                {getRandNum, rw_mem, on_cmp, on_input_block, on_blinker} <= 5'bxxxxx;
                sevenSegDisplay <= 4'bxxxx;
                out_level <= 4'bxxxx;
            end

        endcase

        
    end
    

endmodule