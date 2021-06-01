`timescale 1ns / 1ps

module APB_module(PRDATA, PREADY, PWDATA, PWRITE, PSEL, PENABLE, PADDR, PCLK, PRESETn);
																				
output reg [31:0]PRDATA;
output reg PREADY;
input PWRITE, PSEL, PENABLE, PCLK, PRESETn;							 
input [31:0]PADDR;															 
input [31:0]PWDATA;
  
  
reg [31:0]memory[1023:0];                                      
reg [1:0]state;   															 

parameter IDLE=2'd0;
parameter SETUP=2'd1;
parameter ACCESS=2'd2;

always @(posedge PCLK or negedge PRESETn)
begin

if(PRESETn==1'b0)
	begin
		PREADY <= 1;
		state <= IDLE;
	end
  
else if(PRESETn==1)
	begin
		case(state)
			IDLE :
            begin 
						if(PSEL==1'b0 && PENABLE==1'b0) 
							state<=IDLE;
						else if(PSEL==1'b1 && (PENABLE==1'b1 || PENABLE==1'b0))
							state<=SETUP;
						else
							state<=IDLE;
			end
	
			SETUP :
            begin
              if(PSEL==1'b1 && PENABLE==1'b1 && PREADY==1'b1)
                  begin
						if(PWRITE)
							memory[PADDR]<=PWDATA;
						else
							PRDATA<=memory[PADDR];
							state<=ACCESS;
                  end
              else if(PSEL==1'b1 && PENABLE==1'b0)
                state<=SETUP;
              
              else if(PSEL==1'b0)
                state<=IDLE;
			end
						
			ACCESS :
            begin
				if(PREADY==1'b1 && PSEL==1'b0 && PENABLE==1'b0)
					state<=IDLE;
				else if(PREADY==1'b1 && PSEL==1'b1 && PENABLE==1'b0)
					state<=SETUP;  
              else if(PREADY==1'b0 && PSEL==1'b1 && PENABLE==1'b1)
					state<=ACCESS;
				end
		endcase
	end
end
endmodule
