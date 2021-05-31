`include "environment.sv"

program test(addr_intf intf);
  environment env;
  initial
    begin
      env=new(intf);

      env.gen.gen_count=$urandom_range(10,20);

      env.run();
    end
  endprogram
