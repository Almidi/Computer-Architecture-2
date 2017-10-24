library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity Decoder5to32Test is
end Decoder5to32Test;
architecture Behavioral of Decoder5to32Test is
	component Decoder5to32 is
		Port ( Input : in STD_LOGIC_VECTOR (4 downto 0);
			   Output : out STD_LOGIC_VECTOR (31 downto 0));
	end component;
	signal input: STD_LOGIC_VECTOR (4 downto 0);
	signal output: STD_LOGIC_VECTOR (31 downto 0);
begin
	Decoder5to32Instance: Decoder5to32 port map(input, output);
	SimulationProcess: process
	begin
		for i in 0 to 31 loop
			input<=std_logic_vector(to_unsigned(i,5));
			wait for 100 ns;
		end loop;
		wait;
	end process;
end Behavioral;