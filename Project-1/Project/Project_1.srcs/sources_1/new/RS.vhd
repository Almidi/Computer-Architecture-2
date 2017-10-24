-- Authors: Tzanis Fotakis
--			Apostolos Vailakis


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity RS is
    Port ( WrEn : in STD_LOGIC;
           Op : in STD_LOGIC_VECTOR (1 downto 0);
           Vj : in STD_LOGIC_VECTOR (31 downto 0);
           Vk : in STD_LOGIC_VECTOR (31 downto 0);
           Qj : in STD_LOGIC_VECTOR (4 downto 0);
           Qk : in STD_LOGIC_VECTOR (4 downto 0);
           OpOut : out STD_LOGIC_VECTOR (1 downto 0);
           VjOut : out STD_LOGIC_VECTOR (31 downto 0);
           VkOut : out STD_LOGIC_VECTOR (31 downto 0);
           ReadyOut : out STD_LOGIC;
           CDBQ : in STD_LOGIC_VECTOR (4 downto 0);
           CDBV : in STD_LOGIC_VECTOR (31 downto 0);
           BusyOut : out STD_LOGIC;
           RST : in STD_LOGIC;
           CLK : in STD_LOGIC);
end RS;

architecture Behavioral of RS is

component Register32 is
    Port ( DataIn : in STD_LOGIC_VECTOR (31 downto 0);
           WrEn : in STD_LOGIC;
           Clk : in STD_LOGIC;
           DataOut : out STD_LOGIC_VECTOR (31 downto 0);
           Rst : in STD_LOGIC);
end component;

component Register5 is
    Port ( DataIn : in STD_LOGIC_VECTOR (4 downto 0);
           WrEn : in STD_LOGIC;
           Rst : in STD_LOGIC;
           Clk : in STD_LOGIC;
           DataOut : out STD_LOGIC_VECTOR (4 downto 0));
end component;

component Register2 is
    Port ( DataIn : in STD_LOGIC_VECTOR (1 downto 0);
           WrEn : in STD_LOGIC;
           Rst : in STD_LOGIC;
           Clk : in STD_LOGIC;
           DataOut : out STD_LOGIC_VECTOR (1 downto 0));
end component;

component CompareModule is
    Port ( In0 : in  STD_LOGIC_VECTOR (4 downto 0);
           In1 : in  STD_LOGIC_VECTOR (4 downto 0);
           DOUT : out  STD_LOGIC);
end component;

SIGNAL QjInput : STD_LOGIC_VECTOR (4 downto 0);
SIGNAL QkInput : STD_LOGIC_VECTOR (4 downto 0);

SIGNAL VjInput : STD_LOGIC_VECTOR (31 downto 0);
SIGNAL VkInput : STD_LOGIC_VECTOR (31 downto 0);

SIGNAL QjInternal : STD_LOGIC_VECTOR (4 downto 0);
SIGNAL QkInternal : STD_LOGIC_VECTOR (4 downto 0);

SIGNAL Qj0 : STD_LOGIC; --
SIGNAL Qk0 : STD_LOGIC; --

SIGNAL VjWrEN : STD_LOGIC; -- TODO: OR these things correctly
SIGNAL VkWrEN : STD_LOGIC; --

SIGNAL QjWrEN : STD_LOGIC; -- TODO: OR these things correctly
SIGNAL QkWrEN : STD_LOGIC; --

SIGNAL Comp1Out : STD_LOGIC;
SIGNAL Comp2Out : STD_LOGIC;
SIGNAL Comp3Out : STD_LOGIC;

SIGNAL Inv_Op_Input : STD_LOGIC_VECTOR (1 downto 0);
SIGNAL Inv_Op_Output : STD_LOGIC_VECTOR (1 downto 0);


begin
-- V Registers

VjREG : Register32 Port Map (
		   DataIn =>VjInput,
           WrEn =>VjWrEN,
           Clk =>CLK,
           DataOut =>VjOut,
           Rst =>RST);

VkREG : Register32 Port Map ( 
		   DataIn =>VkInput,
           WrEn =>VkWrEN,
           Clk =>CLK,
           DataOut =>VkOut,
           Rst =>RST);

-- Q Registers

QjREG : Register5 Port Map ( 
		   DataIn =>QjInput,
           WrEn =>QjWrEN,
           Clk =>CLK,
           DataOut =>QjInternal,
           Rst =>RST);

QkREG : Register5 Port Map ( 
		   DataIn =>QkInput,
           WrEn =>QkWrEN,
           Clk =>CLK,
           DataOut =>QkInternal,
           Rst =>RST);
-- OP Register

OpREG : Register2 Port Map ( 
		   DataIn =>Inv_Op_Input,
           WrEn =>WrEn,
           Clk =>CLK,
           DataOut =>Inv_Op_Output,
           Rst =>RST);
-- Comparator

-- CDBQ == Qj
Comp1 : CompareModule Port Map( 
		   In0 =>CDBQ,
           In1 =>QjInternal,
           DOUT =>Comp1Out );
-- CDBQ == Qk
Comp2 : CompareModule Port Map( 
		   In0 =>CDBQ,
           In1 =>QkInternal,
           DOUT =>Comp2Out );
-- CDBQ == 00000
Comp3 : CompareModule Port Map( 
		   In0 =>CDBQ,
           In1 =>"00000",
           DOUT =>Comp3Out );


-- Input-Output Invertion (For Correct Reset)
Inv_Op_Input <= NOT Op ;
OpOut <= NOT Inv_Op_Output ;

-- Busy Signal
BusyOut <= Inv_Op_Output(0) NOR Inv_Op_Output(1) ;

-- Ready Signal 
with QjInternal select
	Qj0 <=      '0' when std_logic_vector(to_unsigned(0,5)),
				'1' when others ;

with QkInternal select
	Qk0 <=      '0' when std_logic_vector(to_unsigned(0,5)),
				'1' when others ;

ReadyOut <= Qj0 NOR Qk0 ;

-- Mask Q Register Input when CDBV Arrived
QjInput(0) <= Qj(0) AND (NOT Comp1Out);
QjInput(1) <= Qj(1) AND (NOT Comp1Out);
QjInput(2) <= Qj(2) AND (NOT Comp1Out);
QjInput(3) <= Qj(3) AND (NOT Comp1Out);
QjInput(4) <= Qj(4) AND (NOT Comp1Out);

QkInput(0) <= Qk(0) AND (NOT Comp2Out);
QkInput(1) <= Qk(1) AND (NOT Comp2Out);
QkInput(2) <= Qk(2) AND (NOT Comp2Out);
QkInput(3) <= Qk(3) AND (NOT Comp2Out);
QkInput(4) <= Qk(4) AND (NOT Comp2Out);

-- Multiplex V Inputs

with Comp1Out select
	VjInput <=      Vj when '0',
					CDBV when others ;

with Comp2Out select
	VkInput <=      Vk when '0',
					CDBV when others ;

-- Registers WrEn ORing

VjWrEN <= WrEn OR (Comp1Out AND (NOT Comp3Out)) ;
VkWrEN <= WrEn OR (Comp2Out AND (NOT Comp3Out)) ;

QjWrEN <= WrEn OR (Comp1Out AND (NOT Comp3Out)) ;
QkWrEN <= WrEn OR (Comp2Out AND (NOT Comp3Out)) ;

end Behavioral;