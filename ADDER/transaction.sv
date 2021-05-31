class transaction;
  
  rand bit [3:0]a;
  rand bit [3:0]b;
  	   bit [6:0]c;
  
  function void print(string name);
    $display("--------------------------");
    $display(" %s",name);
    $display("Value of A => %d",a);
    $display("Value of B => %d",b);
    $display("Value of C => %d",b);
    $display("--------------------------");
  endfunction
endclass
