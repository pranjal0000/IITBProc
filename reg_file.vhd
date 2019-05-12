library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity reg_file is
	
	port (
	   clk        : in   std_logic;
	   rst        : in   std_logic;
	   CTR : in  std_logic_vector(2 downto 0);
	   RF_D1,RF_D2  : out  std_logic_vector(15 downto 0);
	   IR,T1,LS,T2,PC: in  std_logic_vector(15 downto 0);
		S,NS:in std_logic_vector(19 downto 0);
		reg0,reg1,reg2,reg3,reg4,reg5,reg6,reg7: out std_logic_vector(15 downto 0));
  end entity ;
  
  
 architecture behave of reg_file is
 
 signal r0:std_logic_vector(15 downto 0);
 signal r1:std_logic_vector(15 downto 0);
 signal r2:std_logic_vector(15 downto 0); 
 signal r3:std_logic_vector(15 downto 0);
 signal r4:std_logic_vector(15 downto 0);
 signal r5:std_logic_vector(15 downto 0); 
 signal r6:std_logic_vector(15 downto 0); 
 signal r7:std_logic_vector(15 downto 0);
 signal RF_D3:std_logic_vector(15 downto 0);
 signal WR:std_logic; 
 signal A1c: std_logic_vector(2 downto 0);
 signal A3c,D3c: std_logic_vector(3 downto 0);
 signal RF_A1,RF_A2,RF_A3: std_logic_vector(2 downto 0);
 begin



WR <= ((S(3) or S(5)) or (S(6) or S(9))) or ((S(12) or NS(18)) or NS(19));
A1c(0) <= S(1) or S(19);
A1c(1) <= S(4);
A1c(2) <= S(14);
A3c(0) <= S(3);
A3c(1) <= S(5);
A3c(2) <= (S(6) or S(9)) or (NS(18) or NS(19));
A3c(3) <= S(12);
D3c(0) <= (S(3) or S(5)) or S(12);
D3c(1) <= S(6);
D3c(2) <= S(9);
D3c(3) <= NS(18) or NS(19);
  RF_A1 <=
	 IR(8 downto 6) when A1c="001" else
	 IR(11 downto 9) when A1c="010" else
	 CTR when A1c="100";
  
  RF_A2<= 
	 IR(11 downto 9) when S(1)='1';
	 
  RF_D1 <= 
	 r0 when RF_A1 = "000" else 
	 r1 when RF_A1 = "001" else 
	 r2  when RF_A1 = "010" else 
	 r3 when RF_A1 = "011" else
	 r4 when RF_A1 = "100" else
	 r5 when RF_A1 = "101" else
	 r6 when RF_A1 = "110" else
	 r7 when RF_A1 ="111";

  RF_D2 <= 
	 r0 when RF_A2 = "000" else 
	 r1 when RF_A2 = "001" else 
	 r2  when RF_A2 = "010" else 
	 r3 when RF_A2 = "011" else
	 r4 when RF_A2 = "100" else
	 r5 when RF_A2 = "101" else
	 r6 when RF_A2 = "110" else
	 r7 when RF_A2 ="111";
  RF_A3 <=
	 IR(5 downto 3) when A3c="0001" else
	 IR(8 downto 6) when A3c="0010" else
	 IR(11 downto 9) when A3c="0100" else
	 CTR when A3c="1000";
  
  RF_D3 <=
	 T1 when D3c="0001" else
	 LS when D3c="0010" else
	 T2 when D3c="0100" else
	 PC when D3c="1000";

 
 writing: process(clk,WR,RF_A3)
 begin

	if rising_edge(clk) then

			if (WR ='1' and rst='0') then 
			case  RF_A3 is
				when "000" =>  r0 <= RF_D3;
				reg0 <= RF_D3;
				when "001" =>  r1 <= RF_D3;
				reg1 <= RF_D3;
				when "010" =>  r2 <= RF_D3;
				reg2 <= RF_D3;
				when "011" =>  reg3 <= RF_D3;
				r3 <= RF_D3;
				when "100" =>  r4 <= RF_D3;
				reg4 <= RF_D3;
				when "101" =>  r5 <= RF_D3;
				reg5 <= RF_D3;
				when "110" =>  r6 <= RF_D3;
				reg6 <= RF_D3;
				when "111" =>  r7 <= RF_D3;
				reg7 <= RF_D3;
				when others => null;
			end case;
			end if;

		if rst='1' then
			r0 <= "1000000000000001";
			r1 <= "0000000000000011";
			r2 <= "0000000000000011";
			r3 <= "0000000000000001";
			r4 <= "0000000000000000";
			r5 <= "0000000000000010";
			r6 <= "1000000000000000";
			r7 <= "0000000000000101";
			reg0 <= "1000000000000001";
			reg1 <= "0000000000000011";
			reg2 <= "0000000000000011";
			reg3 <= "0000000000000001";
			reg4 <= "0000000000000000";
			reg5 <= "0000000000000010";
			reg6 <= "1000000000000000";
			reg7 <= "0000000000000101";
		end if;
	end if;


end process writing;



 
end architecture behave;
 
 
	
  
  
 
