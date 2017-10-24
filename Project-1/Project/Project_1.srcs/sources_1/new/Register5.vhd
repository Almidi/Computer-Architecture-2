library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity Register5 is
    Port ( DataIn : in STD_LOGIC_VECTOR (4 downto 0);
           WrEn : in STD_LOGIC;
           Rst : in STD_LOGIC;
           Clk : in STD_LOGIC;
           DataOut : out STD_LOGIC_VECTOR (4 downto 0));
end Register5;
architecture Behavioral of Register5 is
begin
process(Rst,Clk)
begin
    if Rst='1' then
        DataOut<=std_logic_vector(to_unsigned(0,5));
    elsif rising_edge(Clk) then
    	if WrEn='1' then
    		DataOut<=DataIn;
    	end if;
    end if;
end process;
end Behavioral;