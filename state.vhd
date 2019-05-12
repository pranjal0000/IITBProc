library std;
use std.standard.all;
library ieee;
use ieee.std_logic_1164.all;

entity stateMachine is
	port(CTR: in std_logic_vector(2 downto 0); alu_out: in std_logic_vector(15 downto 0); Csub,carry,zero: in std_logic;S: in std_logic_vector(19 downto 0);IR_out: in std_logic_vector(15 downto 0);NS: out std_logic_vector(19 downto 0));
end entity;
architecture nextstate of stateMachine is
component Norer is
	port(A:in std_logic_vector(15 downto 0); noring:out std_logic);
end component;
signal flag: std_logic;
begin
f1: Norer
port map(A => alu_out, noring => flag);
SM : process (S,carry,zero,IR_out,flag,Csub) begin
NS(0) <= ((S(3) or S(5)) or (S(6) or S(9))) or ((S(13) or (S(17) or S(18))) or  S(19));
NS(1) <= (S(0) and ((((not(IR_out(15))) and IR_out(14)) or ((not(IR_out(15))) and (not(IR_out(12))))) or (((not(IR_out(12))) and (not(IR_out(13)))) and IR_out(14)))) or (S(0) and (((not(IR_out(15))) and (not(IR_out(14)))) and (not(IR_out(12)))));
NS(2) <= ((S(4) and (not(IR_out(15)))) and (((not(IR_out(14))) and (not(IR_out(13)))) and IR_out(12))) or ((S(1) and (((IR_out(1) and (not(IR_out(0)))) and carry) or (((not(IR_out(1))) and IR_out(0)) and zero) or ((not(IR_out(0))) and (not(IR_out(1)))))) and (((not(IR_out(15))) and (not(IR_out(14)))) and (not(IR_out(12)))));
NS(3) <= (S(2) and (not(IR_out(15)))) and ((not(IR_out(14))) and (not(IR_out(12))));
NS(4) <= (S(0) and (not(IR_out(15)))) and (((not(IR_out(14))) and (not(IR_out(13)))) and IR_out(12));
NS(5) <= (S(2) and (not(IR_out(15)))) and (((not(IR_out(14))) and (not(IR_out(13)))) and IR_out(12)); 
NS(6) <= (S(0) and (not(IR_out(15)))) and (((not(IR_out(14))) and IR_out(13)) and IR_out(12));
NS(7) <= (S(1) and (not(IR_out(15)))) and (IR_out(14) and (not(IR_out(13))));
NS(8) <= (S(7) and (not(IR_out(15)))) and ((IR_out(14) and (not(IR_out(13)))) and (not(IR_out(12))));
NS(9) <= S(8);
NS(10) <= S(7) and (not(IR_out(15))) and IR_out(14) and (not(IR_out(13))) and IR_out(12);
NS(11) <= (((S(1) and (not(IR_out(15)))) and (IR_out(14) and IR_out(13))) and (((not(IR_out(12))) and (not(CTR(0)))) and ((not(CTR(1))) and (not(CTR(2)))))) or (S(12) and (((not(CTR(0))) or (not(CTR(1)))) or (not(CTR(2)))));
NS(14) <= (((S(1) and (not(IR_out(15)))) and (IR_out(14) and IR_out(13))) and ((IR_out(12) and (not(CTR(0)))) and ((not(CTR(1))) and (not(CTR(2)))))) or (S(15) and (((not(CTR(0))) or (not(CTR(1)))) or (not(CTR(2)))));
NS(12) <= S(11);
NS(15) <= S(14);
NS(13) <= S(10) or (((CTR(0) and CTR(1)) and (CTR(2) and (S(12) or S(15)))) or (S(16) and (not(flag)))) or ((S(1) and (((IR_out(1) and (not(IR_out(0)))) and (not(carry))) or (((not(IR_out(1))) and IR_out(0)) and (not(zero))))) and (((not(IR_out(15))) and (not(IR_out(14)))) and (not(IR_out(12))))); 
NS(16) <= (S(1) and IR_out(15)) and (IR_out(14) and ((not(IR_out(13))) and (not(IR_out(12)))));
NS(17) <= (S(16) and flag) and Csub;
NS(18) <= (S(0) and IR_out(15)) and (((not(IR_out(14))) and (not(IR_out(13)))) and (not(IR_out(12)))); 
NS(19) <= (S(0) and IR_out(15)) and (((not(IR_out(14))) and (not(IR_out(13)))) and IR_out(12)); 	
end process SM;
end nextstate;

library std;
use std.standard.all;
library ieee;
use ieee.std_logic_1164.all;

entity stateRegister is
	port(clk,rst: in std_logic ;NS : in std_logic_vector(19 downto 0);state : out std_logic_vector(19 downto 0));
end entity;
architecture stateM of stateRegister is
signal state1:std_logic_vector(19 downto 0);
begin

state_loader: process (rst,clk,NS) begin
	if rst='1' then
		state1 <= "00000000000000000001";
	elsif(rising_edge(clk))then
		state1 <= NS;
	end if;
end process state_loader;
state <= state1;
end stateM;


















