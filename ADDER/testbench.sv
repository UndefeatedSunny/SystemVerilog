`include "interface.sv"
`include "test.sv"

module tb;
  bit clk;
  bit rst;

  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
    end
  initial			// Clock Generation
    begin
      #0 clk =0;
      forever
        begin
          #5 clk = ~(clk);
        end
    end
  initial			// Reset Adding and Removal
    begin
      #0  rst = 1;
      #10 rst = 0;
    end
  
  addr_intf intf(clk,rst);
  test t1(intf);
  
  adder dut(.a(intf.a),
            .b(intf.b),
            .clk(intf.clk),
            .rst(intf.rst),
            .valid(intf.valid),
            .c(intf.c)
           );  
  
    initial
      begin
        #500 $finish;
      end
    
endmodule
