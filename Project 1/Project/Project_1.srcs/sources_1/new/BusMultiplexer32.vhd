----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/24/2017 01:12:48 PM
-- Design Name: 
-- Module Name: BusMultiplexer32 - Behavioral
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

entity BusMultiplexer32 is
    Port ( DataIn : in STD_LOGIC_VECTOR (1023 downto 0);
           DataOut : out STD_LOGIC_VECTOR (31 downto 0);
           Select : in STD_LOGIC_VECTOR (4 downto 0));
end BusMultiplexer32;

architecture Behavioral of BusMultiplexer32 is

begin


end Behavioral;
