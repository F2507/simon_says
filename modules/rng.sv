// Generate a "random" number by continuously iterating over the clock
module rng(input logic clock, input logic reset, output logic [1:0] new_num);
		  
logic [2:0] rand_num;

always_ff @(posedge clock)
  if (reset == 1)
     rand_num <= 1;  
  else
     if (rand_num == 4)
	     rand_num <= 1;
	  else 
	     rand_num++;

assign new_num = rand_num[1:0];

endmodule