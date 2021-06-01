class scoreboard;
  
  int scb_count;
  
  int error;
  
  mailbox mon2scb;
  
  bit [31:0]mem[1024];
  
  function new(mailbox mon2scb);
    this.mon2scb=mon2scb;
    mem[1024]='{default:32'h0000};
  endfunction
  
  task main();
    transaction trans;
    forever 
      begin
        mon2scb.get(trans);
        if(trans.PWRITE)
          begin
            mem[trans.PADDR]=trans.PWDATA;
            $display("memory value=>%d",mem[trans.PADDR]);
          end
        else if(!trans.PWRITE)
          begin
            if(mem[trans.PADDR] != trans.PRDATA)
              begin
                $display("\n FAILED addr=>%d \t ACTUAL PRDATA=>%d \t EXPECTED PRDATA=>%d \n",trans.PADDR,trans.PRDATA,mem[trans.PADDR]);
                error++;
              end
            else
              begin
                $display("\n PASS addr=>%d \t ACTUAL PRDATA=>%d \t EXPECTED PRDATA=>%d \n",trans.PADDR,trans.PRDATA,mem[trans.PADDR]);
              end
          end
        scb_count++;
        trans.print("[ SCOREBOARD ]");
      end
  endtask
  
  
endclass
