class generator;
  
  rand transaction trans;   // Declare Transaction Class 
  mailbox gen2drive;		// Declaration of Mailbox
  event ended;				// Declaration of Event
  
  int gen_count;			// Count
  
  function new(mailbox gen2drive);		// Constructor
    this.gen2drive=gen2drive;
  endfunction
  
  task main();
    repeat(gen_count)
      begin
        trans = new();
        if(!trans.randomize())
          begin
            $fatal("Generator -> Transaction Randomization Failed");
          end
        gen2drive.put(trans);
      end
    -> ended;			// Indication for end of Generation
  endtask
endclass
