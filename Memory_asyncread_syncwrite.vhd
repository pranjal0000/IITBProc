library std;
use std.standard.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;	 
use ieee.std_logic_unsigned.all;

-- since The Memory is asynchronous read, there is no read signal, but you can use it based on your preference.
-- this memory gives 16 Bit data in one clock cycle, so edit the file to your requirement.

entity Memory_asyncread_syncwrite is 
	port (t1_out,t2_out,pc_out: in std_logic_vector(15 downto 0); S,NS: in std_logic_vector(19 downto 0); clk,rst: in std_logic;
				mem_d_out: out std_logic_vector(15 downto 0); m0,m1,m2,m3,m4,m5,m6,m7,m31: out std_logic_vector(15 downto 0));
end entity;

architecture Form of Memory_asyncread_syncwrite is 
type regarray is array(255 downto 0) of std_logic_vector(15 downto 0);   -- defining a new type
signal Memory: regarray:=(
0 => x"3001", 1 => x"60aa", 2 => x"0038", 3 => x"03fa", 4 => x"0079", 5 => x"5f9f", 6 => x"13fb", 7 => x"2038",
	8 => x"233a", 9 => x"2079", 10 => x"4f86",11 => x"4f9f", 12 => x"c9c2", 13 => x"abcd", 14 => x"8e02", 15 => x"1234", 16 => x"7caa", 17 => x"91c0",
	128 => x"ffff", 129 => x"0002", 130 => x"0000", 131 => x"0000", 132 => x"0001", 133 => x"0000",
	others => x"0000");
signal mem_a: std_logic_vector(15 downto 0) := "0000000000000000";
signal mem_d_in:std_logic_vector(15 downto 0) := "0000000000000000";
signal WR: std_logic;
-- you can use the above mentioned way to initialise the memory with the instructions and the data as required to test your processor
begin
m0 <= Memory(conv_integer(0));
m1 <= Memory(conv_integer(1));
m2 <= Memory(conv_integer(2));
m3 <= Memory(conv_integer(3));
m4 <= Memory(conv_integer(4));
m5 <= Memory(conv_integer(5));
m6 <= Memory(conv_integer(6));
m7 <= Memory(conv_integer(7));
m31 <= Memory(conv_integer(31));

WR <= S(10) or S(15);

mem_d_in <= 
x"0000" when rst='1' else
t1_out when S(15)='1' else
t2_out when S(10)='1';

mem_a <=
x"0000" when rst='1' else
pc_out when NS(0)='1' else
t1_out when (S(8) or S(10))='1' else
t2_out when (S(11) or S(15))='1';

mem_d_out <= Memory(conv_integer(mem_a));
Mem_write:
process (WR,mem_d_in,mem_a,clk)
	begin
	if(WR = '1') then
		if(rising_edge(clk)) then
			Memory(conv_integer(mem_a)) <= mem_d_in;
		end if;
	end if;
	end process;
end Form;
