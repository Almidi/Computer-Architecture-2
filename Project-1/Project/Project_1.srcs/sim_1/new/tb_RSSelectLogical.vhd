library ieee;
use ieee.std_logic_1164.all;

entity tb_RSSelectLogical is
end tb_RSSelectLogical;

architecture tb of tb_RSSelectLogical is

    component RSSelectLogical
        port (Executable : in std_logic_vector (2 downto 0);
              Clk        : in std_logic;
              Rst        : in std_logic;
              Tag        : out std_logic_vector (2 downto 0));
    end component;

    signal Executable : std_logic_vector (2 downto 0);
    signal Clk        : std_logic;
    signal Rst        : std_logic;
    signal Tag        : std_logic_vector (2 downto 0);

    constant TbPeriod : time := 10 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : RSSelectLogical
    port map (Executable => Executable,
              Clk        => Clk,
              Rst        => Rst,
              Tag        => Tag);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that Clk is really your main clock signal
    Clk <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        Executable <= (others => '0');

        -- Reset generation
        -- EDIT: Check that Rst is really your reset signal
        Rst <= '1';
        wait for 100 ns;
        Rst <= '0';
        wait for 100 ns;

        -- EDIT Add stimuli here
        Executable<="111";
        wait for 100 ns;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;