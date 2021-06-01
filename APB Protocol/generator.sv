class generator;
  int gen_count;
  
  mailbox gen2drive;
  rand transaction trans; 
  
  event ended;
  
  function new(mailbox gen2drive);
    this.gen2drive=gen2drive;
  endfunction
  
  task main();
    repeat(gen_count)
      begin
        trans=new();
        if(!trans.randomize())
          begin
            $fatal("Generator:: trans randomization FAILED");
          end
        gen2drive.put(trans);
      end;
    ->ended;
  endtask
endclass
