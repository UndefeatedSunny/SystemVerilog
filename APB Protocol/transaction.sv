class transaction;
///////////////////////////////////////////////
  
  rand bit PWRITE;
  
  rand bit [31:0] PADDR;
  rand bit [31:0] PWDATA;
  
  bit [31:0] PRDATA;
  
///////////////////////////////////////////////
  
  constraint check{PADDR < 100;}  
  constraint checking{PWDATA < 1000;}
///////////////////////////////////////////////
  
  function void print(string name);
    $display("--------------------------");
    $display(" %s",name);
    $display("Value of addr => %d",PADDR);
    $display("Value of wdata => %d",PWDATA);
    $display("Value of rdata => %d",PRDATA);
    $display("Value of pwrite => %d",PWRITE);
    $display("--------------------------");
  endfunction  

///////////////////////////////////////////////
endclass
