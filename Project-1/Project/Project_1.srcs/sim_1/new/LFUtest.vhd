library ieee;
use ieee.std_logic_1164.all;

entity LFUtest is
end LFUtest;

architecture tb of LFUtest is

    component LogicalFunctionalUnit
        port (Clk        : in std_logic;
              En         : in std_logic;
              Rst        : in std_logic;
              Grant      : in std_logic;
              Vj         : in std_logic_vector (31 downto 0);
              Vk         : in std_logic_vector (31 downto 0);
              Op         : in std_logic_vector (1 downto 0);
              Tag        : in std_logic_vector (4 downto 0);
              RequestOut : out std_logic;
              BusyOut    : out std_logic;
              ResultOut  : out std_logic_vector (31 downto 0);
              TagOut     : out std_logic_vector (4 downto 0));
    end component;

    signal Clk        : std_logic;
    signal En         : std_logic;
    signal Rst        : std_logic;
    signal Grant      : std_logic;
    signal Vj         : std_logic_vector (31 downto 0);
    signal Vk         : std_logic_vector (31 downto 0);
    signal Op         : std_logic_vector (1 downto 0);
    signal Tag        : std_logic_vector (4 downto 0);
    signal RequestOut : std_logic;
    signal BusyOut    : std_logic;
    signal ResultOut  : std_logic_vector (31 downto 0);
    signal TagOut     : std_logic_vector (4 downto 0);

    constant TbPeriod : time := 1000 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : LogicalFunctionalUnit
    port map (Clk        => Clk,
              En         => En,
              Rst        => Rst,
              Grant      => Grant,
              Vj         => Vj,
              Vk         => Vk,
              Op         => Op,
              Tag        => Tag,
              RequestOut => RequestOut,
              BusyOut    => BusyOut,
              ResultOut  => ResultOut,
              TagOut     => TagOut);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that Clk is really your main clock signal
    Clk <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        En <= '0';
        Grant <= '0';
        Vj <= (others => '0');
        Vk <= (others => '0');
        Op <= (others => '0');
        Tag <= (others => '0');

        -- Reset generation
        -- EDIT: Check that Rst is really your reset signal
        Rst <= '1';
        wait for 5 * TbPeriod;
        Rst <= '0';
        wait for 5 * TbPeriod;

        -- EDIT Add stimuli here
        Vj <= "00000000000000000000000000000001" ;
        Vk <= "00000000000000000000000000000010" ;
        Op <= "00";
        Tag <= "00111";

        wait for TbPeriod;
        En <= '1';
        wait for TbPeriod;
        En <= '0';
        wait for TbPeriod;
        Grant <= '1';
        wait for TbPeriod;
        Grant <= '0';
        wait for 100 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;
