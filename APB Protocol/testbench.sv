`include "interface.sv"
`include "test.sv"

module tb;
  
  bit PCLK;
  bit PRESETn;
/////////////////////////////////////
  
  initial 
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
    end  
/////////////////////////////////////
  
  initial
    begin
      PCLK = 0;
      forever 
        begin
          #5 PCLK = ~PCLK;
        end
    end
/////////////////////////////////////
  
  initial
    begin
      PRESETn=1'b0;
      #5 PRESETn=1'b1;
    end
/////////////////////////////////////
  
  apb_intf intf(PCLK,PRESETn);
  
  test t1(intf);
  
/////////////////////////////////////
  
  APB_module dut
  (
    .PRDATA(intf.PRDATA),
    .PREADY(intf.PREADY),
    .PWDATA(intf.PWDATA),
    .PWRITE(intf.PWRITE),
    .PSEL(intf.PSEL),
    .PENABLE(intf.PENABLE),
    .PADDR(intf.PADDR),
    .PCLK(intf.PCLK), 
    .PRESETn(intf.PRESETn)
  ); 
  
  /*initial
    begin
  		#500	$finish;
    end  */
endmodule
