interface apb_intf(input logic PCLK,PRESETn);
  
	logic [31:0] PWDATA;
	logic PWRITE;
	logic PSEL;
	logic PENABLE;
    logic [31:0] PADDR;
  
	logic [31:0] PRDATA;
	logic PREADY;  
    
endinterface
