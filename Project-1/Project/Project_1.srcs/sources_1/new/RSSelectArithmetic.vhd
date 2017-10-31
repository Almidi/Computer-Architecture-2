library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;
entity RSSelectArithmetic is
    Port ( Executable : in STD_LOGIC_VECTOR (2 downto 0);
           Rst : in STD_LOGIC;
           Tag : out STD_LOGIC_VECTOR (2 downto 0));
end RSSelectArithmetic;
architecture Behavioral of RSSelectArithmetic is
signal priority: std_logic_vector(1 downto 0);
begin
	process(Rst)
	begin
		if Rst='1' then
			priority<="00";
			Tag<="000";
		end if;
	end process;

	process(Executable)
	begin
		if priority="00" then
			if Executable(0)='1' then
				Tag<="001";
			elsif Executable(1)='1' then
				Tag<="010";
			elsif Executable(2)='1' then
				Tag<="011";
			else
				Tag<="000";
			end if;
			priority<="01";
		elsif priority="01" then
			if Executable(1)='1' then
				Tag<="010";
			elsif Executable(2)='1' then
				Tag<="011";
			elsif Executable(0)='1' then
				Tag<="001";
			else
				Tag<="000";
			end if;
			priority<="10";
		else
			if Executable(2)='1' then
				Tag<="011";
			elsif Executable(0)='1' then
				Tag<="001";
			elsif Executable(1)='1' then
				Tag<="010";
			else
				Tag<="000";
			end if;
			priority<="00";
		end if;
	end process;
end Behavioral;