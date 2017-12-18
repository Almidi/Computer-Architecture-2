library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity Register1 is
    Port ( DataIn : in STD_LOGIC;
           WrEn : in STD_LOGIC;
           Rst : in STD_LOGIC;
           Clk : in STD_LOGIC;
           DataOut : out STD_LOGIC);
end Register1;
architecture Behavioral of Register1 is
begin
process(Rst,Clk)
begin
    if Rst='1' then
        DataOut<='0';
    elsif rising_edge(Clk) then
    	if WrEn='1' then
    		DataOut<=DataIn;
    	end if;
    end if;
end process;
end Behavioral;