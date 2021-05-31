class monitor;
  
  mailbox mon2scb;
  virtual addr_intf vif;
  
  function new(mailbox mon2scb,virtual addr_intf vif);
    this.mon2scb=mon2scb;
    this.vif=vif;
  endfunction
  
  task main();
    forever
      begin
        transaction trans;
        trans=new();
        @(posedge vif.clk);
        wait(vif.valid);
        trans.a=vif.a;
        trans.b=vif.b;
        @(posedge vif.clk);
        trans.c=vif.c;
        @(posedge vif.clk);
        mon2scb.put(trans);
        trans.print("[ MONITOR ]");
      end
  endtask
endclass
