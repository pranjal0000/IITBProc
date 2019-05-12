library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
 
 entity DUT is
    
    port (	
	   clk    : in  std_logic;
	   rst		: in std_logic;
	   currentStateOut	: out std_logic_vector(19 downto 0);
	   reg0,reg1,reg2,reg3,reg4,reg5,reg6,reg7 : out std_logic_vector(15 downto 0) 
		);
		
  end entity ;

 architecture behave of DUT is
component counter is 
port(S:in std_logic_vector(19 downto 0); ir_out:in std_logic_vector(15 downto 0); CTR:in std_logic_vector(2 downto 0); clk,rst:in std_logic;next_CTR:out std_logic_vector(2 downto 0));
end component;
component ctrRegister is
	port(clk,rst: in std_logic ;next_CTR : in std_logic_vector(2 downto 0);CTR_out : out std_logic_vector(2 downto 0));
end component;

 component t1 is
 
  port( clk: in std_logic;
	      mem_d_out,RF_D1,ALU_C: in std_logic_vector(15 downto 0);
	      S: in std_logic_vector(19 downto 0);
	      t1_out: out std_logic_vector(15 downto 0));
		
 end component ;
 component t2 is
port( clk: in std_logic;
	      mem_d_out,RF_D2,ALU_C,se6: in std_logic_vector(15 downto 0);
	      S: in std_logic_vector(19 downto 0);
	      t2_out: out std_logic_vector(15 downto 0));
		
  end component ;


  component t3 is
    
  port(
		clk: in std_logic;
		ALU_C: in std_logic_vector(15 downto 0);
		S: in std_logic_vector(19 downto 0);
		t3_out: out std_logic_vector(15 downto 0)
		);
		
  end component ;


  component PC is
    
   port (
	   clk : in   std_logic;
	   S,NS : in  std_logic_vector(19 downto 0);
	   ALU_C,t3_out,RF_D1 : in  std_logic_vector(15 downto 0);
	   PC_out : out std_logic_vector(15 downto 0);
	   rst : in std_logic
     );
		
  end component ;

  component IR is
    
    port (
	  clk : in std_logic;
	  S,NS : in  std_logic_vector(19 downto 0);
	  mem_d_out  : in  std_logic_vector(15 downto 0);
	  IR_output : out  std_logic_vector(15 downto 0));
		
  end component ;

  component leftShift is
    
    port (
	   se9_16      : in  std_logic_vector(15 downto 0);
	   ls      : out  std_logic_vector(15 downto 0)

     );
		
  end component ;

  component se9 is
    
   port (
	   IR_out      : in  std_logic_vector(15 downto 0);
	   se9out      : out  std_logic_vector(15 downto 0)

     );
		
  end component ;

  component se6 is
    
        port (
	   IR_out      : in  std_logic_vector(15 downto 0);
	   se6out      : out  std_logic_vector(15 downto 0));
		
  end component ;

 component reg_file is
    
  port (
	   clk        : in   std_logic;
	   rst        : in   std_logic;
	   CTR : in  std_logic_vector(2 downto 0);
	   RF_D1,RF_D2  : out  std_logic_vector(15 downto 0);
	   IR,T1,LS,T2,PC: in  std_logic_vector(15 downto 0);
		S,NS: in std_logic_vector(19 downto 0);
		reg0,reg1,reg2,reg3,reg4,reg5,reg6,reg7: out std_logic_vector(15 downto 0));	
  end component ;

component Memory_asyncread_syncwrite is

port (t1_out,t2_out,pc_out: in std_logic_vector(15 downto 0); S,NS: in std_logic_vector(19 downto 0); clk,rst: in std_logic;
				mem_d_out: out std_logic_vector(15 downto 0);m0,m1,m2,m3,m4,m5,m6,m7,m31: out std_logic_vector(15 downto 0));

end component;


  component ALU is
port(t1_out,t2_out,pc_out,se6_out,se9_out,ir_out: in std_logic_vector(15 downto 0);S:in std_logic_vector(19 downto 0); ALU_C:out std_logic_vector(15 downto 0);csub:out std_logic;carry,zero:in std_logic;next_carry,next_zero:out std_logic);    
		
  end component ;
  component carryRegister is
	port(clk,rst,next_carry: in std_logic ;carry : out std_logic);
end component;
component zeroRegister is
	port(clk,rst,next_zero: in std_logic ;zero : out std_logic);
end component;


  component stateMachine is
	port(CTR: in std_logic_vector(2 downto 0); alu_out:in std_logic_vector(15 downto 0);Csub,carry,zero: in std_logic;S: in std_logic_vector(19 downto 0);IR_out: in std_logic_vector(15 downto 0);NS: out std_logic_vector(19 downto 0));
end component;

component stateRegister is
	port(clk,rst: in std_logic ;NS : in std_logic_vector(19 downto 0);state : out std_logic_vector(19 downto 0));
end component;

signal pc_out,t1_out,t2_out,t3_out,alu_out,ir_out,ls_out,se6_out,se9_out,rf_d1,rf_d2,mem_d_out,m0,m1,m2,m3,m4,m5,m6,m7,m31: std_logic_vector(15 downto 0);
signal S,NS: std_logic_vector(19 downto 0);
signal carry,zero,next_carry,next_zero,Csub: std_logic;
signal CTR,next_CTR: std_logic_vector(2 downto 0);

begin
currentStateOut <= S;

 c111: counter
port map(S =>S, ir_out => ir_out, CTR => CTR, clk => clk,rst => rst,next_CTR => next_CTR);
ctr_reg: ctrRegister
port map(clk => clk,rst => rst,next_CTR => next_CTR,CTR_out => CTR);
 t11 :t1 
    
    port map( clk => clk,
	      mem_d_out => mem_d_out,RF_D1 => rf_d1,ALU_C => alu_out,
	      S => S,
	      t1_out => t1_out);
		

 t22 :t2 
    
port map( clk => clk,
	      mem_d_out => mem_d_out,RF_D2 => rf_d2,ALU_C => alu_out,se6 => se6_out,
	      S => S,
	      t2_out => t2_out);
		
		

  t33 :t3 
    
 port map(
		clk => clk,
		ALU_C => alu_out, 
		S => S,
		t3_out => t3_out
		);
		
 pcc: pc 
    
   port map(
	   clk => clk,
	   S => S,NS => NS,
	   ALU_C => alu_out,t3_out => t3_out,RF_D1 => rf_d1,
	   PC_out => pc_out,
	   rst => rst
     );
		

  irr :ir 
 port map(
	  clk => clk,
	  S => S, NS => NS,
	  mem_d_out => mem_d_out,
	  IR_output => ir_out);
		

  ls7: leftShift
port map(
	   se9_16 => se9_out,
	   ls => ls_out

     );


		

  see9 :se9 
    
 port map(
	   IR_out => ir_out,
	   se9out => se9_out

     );
		

  see6 :se6 
    
    port map(
	   IR_out => ir_out,
	   se6out => se6_out);

 all_reg: reg_file
    
port map(
	   clk => clk,
	   rst => rst,
	   CTR => CTR,
	   RF_D1 => rf_d1,RF_D2 => rf_d2, 
	   IR => ir_out,T1 => t1_out,LS => ls_out,T2 => t2_out,PC => pc_out, S => S, NS => NS,
	   reg0 => reg0, reg1 => reg1, reg2 => reg2, reg3 => reg3, reg4 => reg4, reg5 => reg5, reg6 => reg6, reg7 => reg7);
		

memory: Memory_asyncread_syncwrite 

port map(t1_out => t1_out,t2_out => t2_out,pc_out => pc_out, S => S,NS => NS, clk => clk, rst => rst,
				mem_d_out => mem_d_out,m0 => m0,m1 => m1,m2 => m2,m3 => m3,m4 => m4,m5 => m5,m6 => m6,m7 => m7,m31 => m31);   
    
  alu_wrp: ALU
  port map(t1_out => t1_out,t2_out => t2_out,pc_out => pc_out,se6_out => se6_out,se9_out => se9_out,ir_out => ir_out,S => S,ALU_C => alu_out,csub => Csub,carry => carry, zero => zero, next_carry => next_carry, next_zero => next_zero);

 state_mach:stateMachine 
port map(CTR => CTR, alu_out => alu_out,Csub => Csub,carry => carry,zero => zero,S => S, IR_out => ir_out, NS => NS);

 statsi: stateRegister
port map(clk => clk, rst => rst, NS => NS, state => S);

carry_reg: carryRegister
port map(clk => clk,rst => rst,next_carry => next_carry,carry => carry);
		
zero_reg: zeroRegister
port map(clk => clk,rst => rst,next_zero => next_zero,zero => zero);




end architecture behave;
