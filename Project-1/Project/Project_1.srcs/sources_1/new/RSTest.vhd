library ieee;
use ieee.std_logic_1164.all;

entity tb_RS is
end tb_RS;

architecture tb of tb_RS is

    component RS
        port (WrEn     : in std_logic;
              Op       : in std_logic_vector (1 downto 0);
              Vj       : in std_logic_vector (31 downto 0);
              Vk       : in std_logic_vector (31 downto 0);
              Qj       : in std_logic_vector (4 downto 0);
              Qk       : in std_logic_vector (4 downto 0);
              OpOut    : out std_logic_vector (1 downto 0);
              VjOut    : out std_logic_vector (31 downto 0);
              VkOut    : out std_logic_vector (31 downto 0);
              ReadyOut : out std_logic;
              CDBQ     : in std_logic_vector (4 downto 0);
              CDBV     : in std_logic_vector (31 downto 0);
              BusyOut  : out std_logic;
              RST      : in std_logic;
              CLK      : in std_logic);
    end component;

    signal WrEn     : std_logic;
    signal Op       : std_logic_vector (1 downto 0);
    signal Vj       : std_logic_vector (31 downto 0);
    signal Vk       : std_logic_vector (31 downto 0);
    signal Qj       : std_logic_vector (4 downto 0);
    signal Qk       : std_logic_vector (4 downto 0);
    signal OpOut    : std_logic_vector (1 downto 0);
    signal VjOut    : std_logic_vector (31 downto 0);
    signal VkOut    : std_logic_vector (31 downto 0);
    signal ReadyOut : std_logic;
    signal CDBQ     : std_logic_vector (4 downto 0);
    signal CDBV     : std_logic_vector (31 downto 0);
    signal BusyOut  : std_logic;
    signal RST      : std_logic;
    signal CLK      : std_logic;

    constant TbPeriod : time := 1000 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : RS
    port map (WrEn     => WrEn,
              Op       => Op,
              Vj       => Vj,
              Vk       => Vk,
              Qj       => Qj,
              Qk       => Qk,
              OpOut    => OpOut,
              VjOut    => VjOut,
              VkOut    => VkOut,
              ReadyOut => ReadyOut,
              CDBQ     => CDBQ,
              CDBV     => CDBV,
              BusyOut  => BusyOut,
              RST      => RST,
              CLK      => CLK);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that CLK is really your main clock signal
    CLK <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        WrEn <= '0';
        Op <= (others => '0');
        Vj <= (others => '0');
        Vk <= (others => '0');
        Qj <= (others => '0');
        Qk <= (others => '0');
        CDBQ <= (others => '0');
        CDBV <= (others => '0');

        -- Reset generation
        -- EDIT: Check that RST is really your reset signal
        RST <= '1';
        wait for 100 ns;
        RST <= '0';
        wait for 100 ns;

        Vj <= "00000000000000000000000000000010";
        Vk <= "00000000000000000000000000000100";
        Qj <= "00010";
        Qk <= "00100";

        wait for  TbPeriod;
        WrEn <= '1' ;
        wait for  TbPeriod;
        WrEn <= '0' ;

        wait for  5* TbPeriod;

        -- CDB STIMULATION

        CDBV <= "00000000000000011000000000000010";
        CDBQ <= "00010";

        wait for  TbPeriod;

        CDBQ <= "00000";

        CDBV <= "00000000000000011000000011000010";
        CDBQ <= "00100";

        wait for  TbPeriod;

        CDBV <= "00000000000000000000000000000000";
        CDBQ <= "00000";

        -- EDIT Add stimuli here
        wait for 100 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;