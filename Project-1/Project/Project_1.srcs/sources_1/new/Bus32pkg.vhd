library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
package Bus32pkg is
	type Bus32 	is array (31 downto 0) 	of STD_LOGIC_VECTOR (31 downto 0);
	type Bus16 	is array (15 downto 0) 	of STD_LOGIC_VECTOR (31 downto 0);
	type Bus8 		is array (7 downto 0) 		of STD_LOGIC_VECTOR (31 downto 0);
	type Bus4 		is array (3 downto 0) 		of STD_LOGIC_VECTOR (31 downto 0);
	type Bus2 		is array (1 downto 0) 		of STD_LOGIC_VECTOR (31 downto 0);
end package;