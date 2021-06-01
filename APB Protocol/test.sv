`include "environment.sv"
program test(apb_intf intf);
  environment env;
  int VALUE=$urandom_range(150,300);
  initial
    begin
      env=new(intf);

      env.gen.gen_count=VALUE;
      $display("VALUE => %d",VALUE);
      env.run();
    end
endprogram
