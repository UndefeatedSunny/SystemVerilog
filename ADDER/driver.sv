class driver;
  
  virtual addr_intf vif;
  mailbox gen2drive;
  int drive_count;
  
  function new(mailbox gen2drive, virtual addr_intf vif);
    this.vif=vif;
    this.gen2drive=gen2drive;
  endfunction
  
  task reset;
    wait(vif.rst);
    $display("Driver Reset Activated");
    vif.a <= 0;
    vif.b <= 0;
    vif.c <= 0;
    vif.valid <= 0;
    wait(!vif.rst);
    $display("Driver Reset ENDED");
  endtask  
  
  task main;
    forever
      begin
        transaction trans;
        gen2drive.get(trans);
        @(posedge vif.clk);
        vif.valid <= 1;
        vif.a <= trans.a;
        vif.b <= trans.b;
        @(posedge vif.clk);
        vif.valid <= 0;
        trans.c <= vif.c;
        @(posedge vif.clk);
        trans.print("[ DRIVER ]");
        drive_count++;
      end
  endtask

endclass
