module sevenSeg(input logic [3:0] counter, output logic [6:0] hex);
		
   // your code goes here	
   // A different outputs for every possible inout
	always @ (counter[3:0]) begin
	    case(counter[3:0])
            4'b0000:  hex = 7'b1000000;

	        4'b0001:  hex = 7'b1111001;
            
            4'b0010:  hex = 7'b0100100;
    
            4'b0011:  hex = 7'b0110000;
            
            4'b0100:  hex = 7'b0011001;
            
            4'b0101:  hex = 7'b0010010;
            
            4'b0110:  hex = 7'b0000010;
            
            4'b0111:  hex = 7'b1111000;
            
            4'b1000:  hex = 7'b0000000;

            4'b1001:  hex = 7'b0010000;
            
            // The default is for the display to be completely off
            default:  hex = 7'b1111111;
            
        endcase
    end	
	
endmodule