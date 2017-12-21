library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity Demux1to16 is
    Port (input : in  STD_LOGIC;
	  output : out  STD_LOGIC_VECTOR (15 downto 0);
	  control : in  STD_LOGIC_VECTOR (3 downto 0));
end Demux1to16;
architecture Structural of Demux1to16 is
	signal temp: std_logic_vector(15 downto 0);
begin
	process(input,control)
	begin
		case control is
			when "0000" =>temp(0)<=input;
			when "0001" =>temp(1)<=input;
			when "0010" =>temp(2)<=input;
			when "0011" =>temp(3)<=input;
			when "0100" =>temp(4)<=input;
			when "0101" =>temp(5)<=input;
			when "0110" =>temp(6)<=input;
			when "0111" =>temp(7)<=input;
			when "1000" =>temp(8)<=input;
			when "1001" =>temp(9)<=input;
			when "1010" =>temp(10)<=input;
			when "1011" =>temp(11)<=input;
			when "1100" =>temp(12)<=input;
			when "1101" =>temp(13)<=input;
			when "1110" =>temp(14)<=input;
			when others=>temp(15)<=input;
		end case;
	end process;
	
	output<=std_logic_vector(0, 16) or temp;
end Structural;