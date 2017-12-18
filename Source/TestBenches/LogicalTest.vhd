library ieee;
use ieee.std_logic_1164.all;

entity LogicalTest is
end LogicalTest;

architecture tb of LogicalTest is

    component Logical
        port (RST        : in std_logic;
              CLK        : in std_logic;
              Issue      : in std_logic;
              Op         : in std_logic_vector (1 downto 0);
              Vj         : in std_logic_vector (31 downto 0);
              Vk         : in std_logic_vector (31 downto 0);
              Qj         : in std_logic_vector (4 downto 0);
              Qk         : in std_logic_vector (4 downto 0);
              CDBV       : in std_logic_vector (31 downto 0);
              CDBQ       : in std_logic_vector (4 downto 0);
              Grant      : in std_logic;
              Available  : out std_logic_vector (2 downto 0);
              VOut       : out std_logic_vector (31 downto 0);
              QOut       : out std_logic_vector (4 downto 0);
              RequestOut : out std_logic);
    end component;

    signal RST        : std_logic;
    signal CLK        : std_logic;
    signal Issue      : std_logic;
    signal Op         : std_logic_vector (1 downto 0);
    signal Vj         : std_logic_vector (31 downto 0);
    signal Vk         : std_logic_vector (31 downto 0);
    signal Qj         : std_logic_vector (4 downto 0);
    signal Qk         : std_logic_vector (4 downto 0);
    signal CDBV       : std_logic_vector (31 downto 0);
    signal CDBQ       : std_logic_vector (4 downto 0);
    signal Grant      : std_logic;
    signal Available  : std_logic_vector (2 downto 0);
    signal VOut       : std_logic_vector (31 downto 0);
    signal QOut       : std_logic_vector (4 downto 0);
    signal RequestOut : std_logic;

    constant TbPeriod : time := 1000 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : Logical
    port map (RST        => RST,
              CLK        => CLK,
              Issue      => Issue,
              Op         => Op,
              Vj         => Vj,
              Vk         => Vk,
              Qj         => Qj,
              Qk         => Qk,
              CDBV       => CDBV,
              CDBQ       => CDBQ,
              Grant      => Grant,
              Available  => Available,
              VOut       => VOut,
              QOut       => QOut,
              RequestOut => RequestOut);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that CLK is really your main clock signal
    CLK <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        Issue <= '0';
        Op <= (others => '0');
        Vj <= (others => '0');
        Vk <= (others => '0');
        Qj <= (others => '0');
        Qk <= (others => '0');
        CDBV <= (others => '0');
        CDBQ <= (others => '0');
        Grant <= '0';

        -- Reset generation
        -- EDIT: Check that RST is really your reset signal
        RST <= '1';
        wait for 5 * TbPeriod;
        RST <= '0';
        wait for TbPeriod;

        -- EDIT Add stimuli here
        Op <= "01";
        Vj <= "00000000000000000000000000111000";
        Vk <= "00000000000000000000000000000111";
        Qj <= "00000";
        Qk <= "00010";

        wait for TbPeriod;
        Issue <= '1';
        wait for TbPeriod;
        Issue <= '0';
        wait for TbPeriod;

        CDBV <= "00000000000000000000000000000000";
        CDBQ <= "00010";

        wait for 4*TbPeriod;

        Grant <= '1';
        wait for TbPeriod;
        Grant <= '0';
        wait for 100 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;
