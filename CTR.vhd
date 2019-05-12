library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter is 
	port(	S:in std_logic_vector(19 downto 0);
			ir_out:in std_logic_vector(15 downto 0);
			CTR:in std_logic_vector(2 downto 0);
			clk,rst:in std_logic;
			next_CTR:out std_logic_vector(2 downto 0));
end entity;

architecture count of counter is
component threeBitAdder is 
port(A,B:in std_logic_vector(2 downto 0); Z:out std_logic_vector(2 downto 0));
end component;
signal INIT: std_logic;
--signal C:std_logic_vector(3 downto 0);
begin
--C(0) <= '1';
INIT <= ((S(1) and (not(ir_out(15)))) and (((ir_out(14))) and ((ir_out(13))))) or rst or S(13);
increment:process(S,rst,clk)
begin
if (rst='0' and ((S(11)='1') or (S(14)='1'))) then
   if(rising_edge(clk) and ((not(CTR(2))) or ((not(CTR(1))) or (not(CTR(0)))))='1') then
	 --  next_CTR(0) <= CTR(0) xor C(0);
	 --  C(1) <= CTR(0) and C(0);
		--next_CTR(1) <= CTR(1) xor C(1);
	 --  C(2) <= CTR(1) and C(1);
		--next_CTR(2) <= CTR(2) xor C(2);
	 --  C(3) <= CTR(2) and C(2);

	 next_ctr(0) <= not ctr(0);
	 next_ctr(1) <= ctr(0) xor ctr(1);
	 next_ctr(2) <= (ctr(0) and ctr(1)) xor ctr(2);
   end if;
	--if(INIT ='1') then
	--	next_CTR <= "000";
	--end if;
end if;
	if(INIT ='1') then
		next_CTR <= "000";
	end if;

   
end process increment;

end count;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity ctrRegister is
	port(clk,rst: in std_logic ;next_CTR : in std_logic_vector(2 downto 0);CTR_out : out std_logic_vector(2 downto 0));
end entity;
architecture ctrM of ctrRegister is
signal temp:std_logic_vector(2 downto 0);
begin

ctr_loader: process (rst,clk,next_CTR) begin
	if rst='1' then
		temp <= "000";
		ctr_out <= "000";
	elsif(rising_edge(clk))then
		temp <= next_CTR;
		ctr_out <= next_ctr;
	end if;
end process ctr_loader;

end ctrM;



