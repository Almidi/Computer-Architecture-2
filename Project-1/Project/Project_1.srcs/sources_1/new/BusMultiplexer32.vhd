library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use ieee.STD_LOGIC_UNSIGNED.all;
use work.Bus32pkg.ALL;
entity BusMultiplexer32 is
    Port (		Input : in Bus32;
				Sel : in  STD_LOGIC_VECTOR (4 downto 0);
				Output : out  STD_LOGIC_VECTOR (31 downto 0));
end BusMultiplexer32;
architecture Behavioral of BusMultiplexer32 is
begin
	with Sel select
		output <= 	Input(0) when std_logic_vector(to_unsigned(0,32)),
					Input(1) when std_logic_vector(to_unsigned(1,32)),
					Input(2) when std_logic_vector(to_unsigned(2,32)),
					Input(3) when std_logic_vector(to_unsigned(3,32)),
					Input(4) when std_logic_vector(to_unsigned(4,32)),
					Input(5) when std_logic_vector(to_unsigned(5,32)),
					Input(6) when std_logic_vector(to_unsigned(6,32)),
					Input(7) when std_logic_vector(to_unsigned(7,32)),
					Input(8) when std_logic_vector(to_unsigned(8,32)),
					Input(9) when std_logic_vector(to_unsigned(9,32)),
					Input(10) when std_logic_vector(to_unsigned(10,32)),
					Input(11) when std_logic_vector(to_unsigned(11,32)),
					Input(12) when std_logic_vector(to_unsigned(12,32)),
					Input(13) when std_logic_vector(to_unsigned(13,32)),
					Input(14) when std_logic_vector(to_unsigned(14,32)),
					Input(15) when std_logic_vector(to_unsigned(15,32)),
					Input(16) when std_logic_vector(to_unsigned(16,32)),
					Input(17) when std_logic_vector(to_unsigned(17,32)),
					Input(18) when std_logic_vector(to_unsigned(18,32)),
					Input(19) when std_logic_vector(to_unsigned(19,32)),
					Input(20) when std_logic_vector(to_unsigned(20,32)),
					Input(21) when std_logic_vector(to_unsigned(21,32)),
					Input(22) when std_logic_vector(to_unsigned(22,32)),
					Input(23) when std_logic_vector(to_unsigned(23,32)),
					Input(24) when std_logic_vector(to_unsigned(24,32)),
					Input(25) when std_logic_vector(to_unsigned(25,32)),
					Input(26) when std_logic_vector(to_unsigned(26,32)),
					Input(27) when std_logic_vector(to_unsigned(27,32)),
					Input(28) when std_logic_vector(to_unsigned(28,32)),
					Input(29) when std_logic_vector(to_unsigned(29,32)),
					Input(30) when std_logic_vector(to_unsigned(30,32)),
					Input(31) when std_logic_vector(to_unsigned(31,32));
end Behavioral;
