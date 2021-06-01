`include "transaction.sv"
`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"

class environment;
  
  virtual apb_intf vif;
  
  generator gen;
  driver drive;
  monitor mtr;
  scoreboard scb;  
  
  mailbox gen2drive;
  mailbox mon2scb;  
  
  function new(virtual apb_intf vif);
    this.vif=vif;
    
    gen2drive=new();
    mon2scb=new();
    gen=new(gen2drive);
    drive=new(gen2drive,vif);
    mtr=new(mon2scb,vif);
    scb=new(mon2scb);
    
  endfunction
  
  task pre;
    drive.reset();
  endtask
  
  task main();
    fork
      gen.main();
      drive.main();
      mtr.main();
      scb.main();
    join_any
  endtask
  
  task post;
    wait(gen.ended.triggered);
    wait(gen.gen_count == drive.drive_count);
    wait(gen.gen_count==scb.scb_count);
    if(scb.error > 0)
      begin
        $display("\n----------------------------------------------\n");
        $display("ALL CONDITIONS NOT PASSED");
        $display("\n----------------------------------------------\n");
      end
    else
      begin
        $display("\n----------------------------------------------\n");
        $display("ALL CONDITIONS PASSED");
        $display("\n----------------------------------------------\n");
      end
  endtask  
  
  task run();
    pre();
    main();
    post();
    $finish;
  endtask
endclass
