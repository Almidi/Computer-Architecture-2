----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/24/2017 01:12:17 PM
-- Design Name: 
-- Module Name: RS - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RS is
    Port ( WrEn : in STD_LOGIC;
           Op : in STD_LOGIC_VECTOR (1 downto 0);
           Vj : in STD_LOGIC_VECTOR (31 downto 0);
           Vk : in STD_LOGIC_VECTOR (31 downto 0);
           Qj : in STD_LOGIC_VECTOR (4 downto 0);
           Qk : in STD_LOGIC_VECTOR (4 downto 0);
           OpOut : out STD_LOGIC_VECTOR (2 downto 0);
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

begin


end Behavioral;
