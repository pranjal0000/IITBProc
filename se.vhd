library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity se6 is
    
    port (
	   IR_out      : in  std_logic_vector(15 downto 0);
	   se6out      : out  std_logic_vector(15 downto 0));
		
  end entity ;
  
  architecture behave of se6 is
  begin
  
  se6out(5 downto 0) <= IR_out(5 downto 0);
  gen6: for i in 6 to 15 generate
	se6out(i) <= IR_out(5);
  end generate gen6;
  
  
  end architecture behave;
  
  library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity se9 is
    
    port (
	   IR_out      : in  std_logic_vector(15 downto 0);
	   se9out      : out  std_logic_vector(15 downto 0)

     );
		
  end entity ;
  
  architecture behave of se9 is
  begin
  
  se9out(8 downto 0) <= IR_out(8 downto 0);
   gen9: for i in 9 to 15 generate
	se9out(i) <= IR_out(8);
  end generate gen9;
  
  
  end architecture behave;
  
  
  
  
