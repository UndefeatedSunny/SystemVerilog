class scoreboard;
  
  mailbox mon2scb;
  
  int score_count;
  
  function new(mailbox mon2scb);
    this.mon2scb=mon2scb;
  endfunction  
  
  task main;
    transaction trans;
    forever
      begin
        mon2scb.get(trans);
        if((trans.a+trans.b)==trans.c)
          begin
            $display("CORRECT");
          end
        else
          begin
            $display("WRONG, \t Expected output =>%d",(trans.a+trans.b));
          end
        score_count++;
        trans.print("[ SCOREBOARD ]");
      end
  endtask
endclass
