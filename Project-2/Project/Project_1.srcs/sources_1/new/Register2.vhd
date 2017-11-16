library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity Register2 is
    Port ( DataIn : in STD_LOGIC_VECTOR (1 downto 0);
           WrEn : in STD_LOGIC;
           Rst : in STD_LOGIC;
           Clk : in STD_LOGIC;
           DataOut : out STD_LOGIC_VECTOR (1 downto 0));
end Register2;
architecture Behavioral of Register2 is
begin
process(Rst,Clk)
begin
    if Rst='1' then
        DataOut<=std_logic_vector(to_unsigned(0,2));
    elsif rising_edge(Clk) then
      if WrEn='1' then
        DataOut<=DataIn;
      end if;
    end if;
end process;
end Behavioral;