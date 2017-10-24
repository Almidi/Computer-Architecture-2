-- Authors: Tzanis Fotakis
--			Apostolos Vailakis


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

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
           CDBQ : in STD_LOGIC_VECTOR (5 downto 0);
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


SIGNAL QjInternal : STD_LOGIC_VECTOR (4 downto 0);
SIGNAL QkInternal : STD_LOGIC_VECTOR (4 downto 0);
SIGNAL VjWrEN : STD_LOGIC; -- TODO: OR these things correctly
SIGNAL VkWrEN : STD_LOGIC; --

SIGNAL Inv_Op_Input : STD_LOGIC_VECTOR (1 downto 0);
SIGNAL Inv_Op_Output : STD_LOGIC_VECTOR (1 downto 0);

SIGNAL BUSY : STD_LOGIC; --



begin

VjREG : Register32 Port Map (
		   DataIn =>Vj,
           WrEn =>VjWrEN,
           Clk =>CLK,
           DataOut =>VjOut,
           Rst =>RST);

VkREG : Register32 Port Map ( 
		   DataIn =>Vk,
           WrEn =>VkWrEN,
           Clk =>CLK,
           DataOut =>VkOut,
           Rst =>RST);


QjREG : Register5 Port Map ( 
		   DataIn =>Qk,
           WrEn =>WrEn,
           Clk =>CLK,
           DataOut =>QjInternal,
           Rst =>RST);

QkREG : Register5 Port Map ( 
		   DataIn =>Qk,
           WrEn =>WrEn,
           Clk =>CLK,
           DataOut =>QkInternal,
           Rst =>RST);

OpREG : Register2 Port Map ( 
		   DataIn =>Inv_Op_Input,
           WrEn =>WrEn,
           Clk =>CLK,
           DataOut =>Inv_Op_Output,
           Rst =>RST);


BusyOut <= OpOut(0) NOR OpOut(1) ;
Inv_Op_Input <= NOT Op ;
OpOut <= NOT Inv_Op_Output ;


end Behavioral;