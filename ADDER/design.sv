module adder(input [3:0]a, 
             input [3:0]b, 
             input clk, rst, valid, 
             output [6:0]c
            );

  reg [6:0] temp_c;			// Create Temporary Variable
  
  always @(posedge clk)		// Check Positive Edge of Clock
    begin
      temp_c <= (a+b);
    end
  
  always @(posedge rst)		// Check Positive Edge of Reset
    begin
      temp_c <= (0);
    end  
  
  assign c=temp_c;
  
endmodule

/*
	always @(posedge clk or posedge rst)
    begin
      if(rst)
        temp_c <= 0;
      else
        temp_c <= (a+b);
    end
*/
