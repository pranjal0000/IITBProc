library std;
use std.standard.all;
library ieee;
use ieee.std_logic_1164.all;

entity ALU is 
port(t1_out,t2_out,pc_out,se6_out,se9_out,ir_out: in std_logic_vector(15 downto 0);S:in std_logic_vector(19 downto 0); ALU_C:out std_logic_vector(15 downto 0);csub:out std_logic;carry,zero:in std_logic;next_carry,next_zero:out std_logic);
end entity;
architecture functional of ALU is
component Adder is
port(A,B:in std_logic_vector(15 downto 0); output: out std_logic_vector(15 downto 0);Cout: out std_logic);
end component Adder;
component Subtract is
port(A,B:in std_logic_vector(15 downto 0); output: out std_logic_vector(15 downto 0);Cout: out std_logic);
end component Subtract;
component Nander is
port(A,B:in std_logic_vector(15 downto 0); output: out std_logic_vector(15 downto 0));
end component;
component Norer is
port(A:in std_logic_vector(15 downto 0); noring:out std_logic);
end component;
signal outadd,outsub,outnand,ALU_A,ALU_B,temporary:std_logic_vector(15 downto 0);
signal cadd,zero_change_add,zero_change_other,carry_change,noring,flag2: std_logic;
signal control: std_logic_vector(1 downto 0);
begin
zero_change_add <= S(2);
zero_change_other <= S(9);
carry_change <= (S(2) and (not(ir_out(15)))) and ((not(ir_out(14))) and (not(ir_out(13))));
control <=
"00" when ((((S(0) or S(2)) or (S(7) or S(11))) or ((S(15) or S(17)) or S(18)))='1') and (S(16)='0' and (not((((S(2) and (not(ir_out(15)))) and (((not(ir_out(14))) and ir_out(13)) and (not(ir_out(12))))) ='1')))) else
"10" when (((S(2) and (not(ir_out(15)))) and (((not(ir_out(14))) and ir_out(13)) and (not(ir_out(12))))) ='1') else
"01" when S(16)='1';




ALU_A <=
t1_out when ((S(2) or S(7)) or S(16))='1' else
t2_out when (S(11) or S(15))='1' else
pc_out when ((S(0) or S(17)) or S(18))='1';
ALU_B <=
"0000000000000001" when ((S(0) or S(11)) or S(15))='1' else
t2_out when (S(2) or S(16))='1' else
se9_out when S(18)='1' else
se6_out when (S(7) or S(17))='1';
f1: Adder
port map(A => ALU_A, B => ALU_B, output => outadd,Cout => cadd);
f2: Subtract
port map(A => ALU_A, B => ALU_B, output => outsub,Cout => csub);
f3: Nander
port map(A => ALU_A, B => ALU_B, output => outnand);
ALU_C <=
outadd when control="00" else
outsub when control="01" else
outnand when control="10";
temporary <=
outadd when control ="00" else
outsub when control ="01" else
outnand when control="10";
f4: Norer
port map(A => temporary, noring => noring);
f5: Norer
port map(A => t2_out, noring => flag2);
next_zero <=
noring when zero_change_add='1' else
flag2 when zero_change_other='1' else
zero when (zero_change_add='0' and zero_change_other='0');

next_carry <=
cadd when (control="00" and carry_change='1') else
carry when (not(control="00" and carry_change='1'));
end functional;

library std;
use std.standard.all;
library ieee;
use ieee.std_logic_1164.all;
entity Nander is
port(A,B:in std_logic_vector(15 downto 0); output: out std_logic_vector(15 downto 0));
end entity;
architecture nande of Nander is
begin
genNander: for i in 0 to 15 generate
output(i) <= not(A(i) and B(i));
end generate genNander;
end nande;


library std;
use std.standard.all;
library ieee;
use ieee.std_logic_1164.all;
entity Adder is
port(A,B:in std_logic_vector(15 downto 0); output: out std_logic_vector(15 downto 0);Cout: out std_logic);
end entity;
architecture add of Adder is
signal C:std_logic_vector(16 downto 0);
begin
C(0) <= '0';
genAdd: for i in 0 to 15 generate
output(i) <= (A(i) xor B(i)) xor C(i);
C(i+1) <= (A(i) and B(i)) or (C(i) and (A(i) xor B(i)));
end generate genAdd;
Cout <= C(16);
end add;

library std;
use std.standard.all;
library ieee;
use ieee.std_logic_1164.all;
entity Subtract is 
port(A,B:in std_logic_vector(15 downto 0); output: out std_logic_vector(15 downto 0);Cout: out std_logic);
end entity;
architecture sub of Subtract is
signal ones,twos:std_logic_vector(15 downto 0);
signal t:std_logic;
component Adder is
port(A,B:in std_logic_vector(15 downto 0); output: out std_logic_vector(15 downto 0);Cout: out std_logic);
end component Adder;
begin
genOnes: for i in 0 to 15 generate
ones(i) <= not B(i);
end generate genOnes;
a1: Adder
port map(A => ones, B => "0000000000000001", output => twos, Cout => t);
a2: Adder
port map(A => A, B=> twos, output => output, Cout => Cout);
end sub;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity carryRegister is
	port(clk,rst,next_carry: in std_logic ;carry : out std_logic);
end entity;
architecture carryM of carryRegister is
signal temp:std_logic;
begin

carry_loader: process (rst,clk,next_carry) begin
	if rst='1' then
		temp <= '0';
	elsif(rising_edge(clk))then
		temp <= next_carry;
	end if;
end process carry_loader;
carry <= temp;
end carryM;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity zeroRegister is
	port(clk,rst,next_zero: in std_logic ;zero : out std_logic);
end entity;
architecture zeroM of zeroRegister is
signal temp:std_logic;
begin

zero_loader: process (rst,clk,next_zero) begin
	if rst='1' then
		temp <= '0';
	elsif(rising_edge(clk))then
		temp <= next_zero;
	end if;
end process zero_loader;
zero <= temp;
end zeroM;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity Norer is
	port(A:in std_logic_vector(15 downto 0); noring:out std_logic);
end entity;

architecture norer1 of Norer is
begin
noring <=
'1' when A="0000000000000000" else
'0' ;
end norer1;


