class monitor;
  
  mailbox mon2scb;
  virtual apb_intf vif;
  
  function new(mailbox mon2scb,virtual apb_intf vif);
    this.mon2scb=mon2scb;
    this.vif=vif;
  endfunction
  
  task main();
    forever
      begin
        transaction trans;
        trans=new();
        @(posedge vif.PCLK);
                 
        trans.PADDR=vif.PADDR;
        if(vif.PWRITE)
          begin
            trans.PWDATA=vif.PWDATA;
        	trans.PWRITE=vif.PWRITE;
          end
        else
          begin
            trans.PWRITE=vif.PWRITE;
            trans.PRDATA=vif.PRDATA;
          end
        
        @(posedge vif.PCLK);
        mon2scb.put(trans);
        trans.print("[ MONITOR ]");
      end
  endtask
endclass
