library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity IR is
    
    port (
	  clk : in std_logic;
	  S,NS: in  std_logic_vector(19 downto 0);
	  mem_d_out  : in  std_logic_vector(15 downto 0);
	  IR_output : out  std_logic_vector(15 downto 0));
		
  end entity ;
  
  architecture behave of IR is

  signal WR: std_logic;
  signal Temp: std_logic_vector(15 downto 0);

  begin

WR <= S(0) ;
IR_output <= Temp;

output:process(clk,WR)
 begin
 	if (falling_edge(clk)) then
		 case WR is
			when '1' =>  Temp <= mem_d_out;
			when others =>  Temp <= Temp;
		end case;
	end if;
end process output;
 
end architecture behave;
