library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PC is
    
    port (
	   clk : in   std_logic;
	   S,NS : in  std_logic_vector(19 downto 0);
	   ALU_C,t3_out,RF_D1 : in  std_logic_vector(15 downto 0);
	   PC_out : out std_logic_vector(15 downto 0);
	   rst : in std_logic
     );
		
  end entity ;
  
  architecture behave of PC is

  signal pcc: std_logic_vector(2 downto 0);
  signal Temp: std_logic_vector(15 downto 0);
  signal WR: std_logic;
  begin

  pcc(0) <= (S(3) or S(5)) or ((S(6) or S(9)) or S(13));
  pcc(1) <= S(17) or S(18);
  pcc(2) <= S(19);
  WR <= ((S(3) or S(5)) or (S(6) or S(9)))  or S(13) or ((S(17) or S(18)) or S(19));
  PC_out <= Temp;

output:process(rst,clk,pcc)
 begin
 if rst = '1' then
 	Temp <= "0000000000000000";
 elsif (falling_edge(clk) and WR='1') then
	 case pcc is
		when "001" =>  Temp <= t3_out;
		when "010" =>  Temp <= ALU_C;
		when "100" =>  Temp <= RF_D1;
		when others => Temp <= Temp;
	 end case;
	end if;
 end process output;

  
  
  
  end architecture behave;
  
  
  
