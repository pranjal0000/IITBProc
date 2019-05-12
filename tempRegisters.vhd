library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity t1 is
	port( clk: in std_logic;
	      mem_d_out,RF_D1,ALU_C: in std_logic_vector(15 downto 0);
	      S: in std_logic_vector(19 downto 0);
	      t1_out: out std_logic_vector(15 downto 0));
end entity;
architecture behave of t1 is
signal t1c: std_logic_vector(2 downto 0);
signal WR: std_logic;
signal Temp: std_logic_vector(15 downto 0);
	begin
	WR <= ((S(1) or S(2)) or (S(4) or S(7))) or (S(11) or S(14));
	t1c(0) <= S(11);
        t1c(1) <= (S(1) or S(4)) or S(14);
	t1c(2) <= S(2) or S(7);
	t1_out <= Temp;
output:process(clk,t1c)
 begin
 if (rising_edge(clk) and WR='1') then
	 case t1c is
		when "001" =>  Temp <= mem_d_out;
		when "010" =>  Temp <= RF_D1;
		when "100" =>  Temp <= ALU_C;
		when others =>  Temp <= Temp;
	 end case;
 end if;
 end process output;
end architecture behave;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity t2 is
	port( clk: in std_logic;
	      mem_d_out,RF_D2,ALU_C,se6: in std_logic_vector(15 downto 0);
	      S: in std_logic_vector(19 downto 0);
	      t2_out: out std_logic_vector(15 downto 0));
end entity;
architecture behave of t2 is
signal t2c: std_logic_vector(3 downto 0);
signal WR: std_logic;
signal Temp: std_logic_vector(15 downto 0);
	begin
	WR <= (S(1) or S(4)) or ((S(8) or S(11)) or S(15));
	t2c(0) <= S(8);
        t2c(1) <= S(1);
	t2c(2) <= S(11) or S(15);
	t2c(3) <= S(4);
	t2_out <= Temp;
output:process(clk,t2c)
 begin
 if (rising_edge(clk) and WR='1') then
	 case t2c is
		when "0001" =>  Temp <= mem_d_out;
		when "0010" =>  Temp <= RF_D2;
		when "0100" =>  Temp <= ALU_C;
		when "1000" => Temp <= se6;
		when others =>  Temp <= Temp;
	 end case;
 end if;
 end process output;
end architecture behave;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity t3 is

	port(
		clk: in std_logic;
		ALU_C: in std_logic_vector(15 downto 0);
		S: in std_logic_vector(19 downto 0);
		t3_out: out std_logic_vector(15 downto 0)
		);
	end entity;
	
architecture behave of t3 is
signal Temp: std_logic_vector(15 downto 0);
signal WR: std_logic;
begin
	WR <= S(0);
	t3_out <= Temp;
output: process(clk)
begin
 if (rising_edge(clk) and WR='1') then
	 case WR is
		when '1' =>  Temp <= ALU_C;
		when others =>  Temp <= Temp;
	 end case;
 end if;
 end process output;	
end behave;

