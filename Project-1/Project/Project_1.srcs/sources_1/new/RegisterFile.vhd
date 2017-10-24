----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/24/2017 01:12:48 PM
-- Design Name: 
-- Module Name: RegisterFile - Structural
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

entity RegisterFile is
    Port ( ReadAddr1 : in STD_LOGIC_VECTOR (4 downto 0);
           ReadAddr2 : in STD_LOGIC_VECTOR (4 downto 0);
           CDBQ : in STD_LOGIC_VECTOR (4 downto 0);
           CDBV : in STD_LOGIC_VECTOR (31 downto 0);
           Tag : in STD_LOGIC_VECTOR (4 downto 0);
           WrEn : in STD_LOGIC;
           AddrW : in STD_LOGIC_VECTOR (4 downto 0);
           Clk : in STD_LOGIC;
           Reset : in STD_LOGIC;
           DataOut1 : out STD_LOGIC_VECTOR (31 downto 0);
           DataOut2 : out STD_LOGIC_VECTOR (31 downto 0));
end RegisterFile;

architecture Structural of RegisterFile is

begin


end Structural;
