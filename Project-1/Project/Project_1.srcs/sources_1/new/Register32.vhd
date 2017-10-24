library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity Register32 is
    Port ( DataIn : in STD_LOGIC_VECTOR (31 downto 0);
           WrEn : in STD_LOGIC;
           Clk : in STD_LOGIC;
           DataOut : out STD_LOGIC_VECTOR (31 downto 0);
           Rst : in STD_LOGIC);
end Register32;
architecture Behavioral of Register32 is
begin
process(Rst,Clk)
begin
    if Rst='1' then
        DataOut<=std_logic_vector(to_unsigned(0,32));
    elsif rising_edge(Clk) then
    	if WrEn='1' then
    		DataOut<=DataIn;
    	end if;
    end if;
end process;
end Behavioral;