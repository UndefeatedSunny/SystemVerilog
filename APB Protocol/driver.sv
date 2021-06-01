class driver;
////////////////////////////////////////////////////////
  
  virtual apb_intf vif;
  mailbox gen2drive;
  
  int drive_count;
////////////////////////////////////////////////////////
  
  function new(mailbox gen2drive, virtual apb_intf vif);
    this.vif=vif;
    this.gen2drive=gen2drive;
  endfunction
////////////////////////////////////////////////////////
  
  task reset;
    wait(!vif.PRESETn);
    $display("Driver Reset Activated");
    vif.PWRITE <= 0;
    vif.PADDR <= 0;
    vif.PWDATA <= 0;
    vif.PSEL <= 0;
    vif.PENABLE <= 0;
    wait(vif.PRESETn);
    $display("Driver Reset ENDED");
  endtask  
////////////////////////////////////////////////////////
  task main;
    forever
      begin
        transaction trans;
        gen2drive.get(trans);
        vif.PREADY<=1;
        vif.PADDR <= trans.PADDR;
        
        @(posedge vif.PCLK);
        vif.PSEL <= 1;
        vif.PENABLE <= 0;
        
        @(posedge vif.PCLK);
        vif.PENABLE <= 1;

        if(trans.PWRITE)
          begin
            vif.PWRITE=trans.PWRITE;
            vif.PWDATA=trans.PWDATA;
          end
        else if(!trans.PWRITE)
          begin
            vif.PWRITE=trans.PWRITE;
            trans.PRDATA=vif.PRDATA;
          end          
        trans.print("[ DRIVER ]");
        drive_count++;
      end
  endtask  

endclass
