library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity leftShift is
    
    port (
	   se9_16      : in  std_logic_vector(15 downto 0);
	   ls      : out  std_logic_vector(15 downto 0)

     );
		
  end entity ;
  
  architecture behave of leftShift is
  begin
  
  ls(6 downto 0) <= (others => '0');
  ls(15 downto 7) <= se9_16(8 downto 0);
  
  
  end architecture behave;
  
  
  
