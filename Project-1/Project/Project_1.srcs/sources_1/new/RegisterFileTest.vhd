library ieee;
use ieee.std_logic_1164.all;

entity tb_RegisterFile is
end tb_RegisterFile;

architecture tb of tb_RegisterFile is

    component RegisterFile
        port (ReadAddr1 : in std_logic_vector (4 downto 0);
              ReadAddr2 : in std_logic_vector (4 downto 0);
              CDBQ      : in std_logic_vector (4 downto 0);
              CDBV      : in std_logic_vector (31 downto 0);
              Tag       : in std_logic_vector (4 downto 0);
              WrEn      : in std_logic;
              AddrW     : in std_logic_vector (4 downto 0);
              Clk       : in std_logic;
              Rst       : in std_logic;
              DataOut1  : out std_logic_vector (31 downto 0);
              DataOut2  : out std_logic_vector (31 downto 0));
    end component;

    signal ReadAddr1 : std_logic_vector (4 downto 0);
    signal ReadAddr2 : std_logic_vector (4 downto 0);
    signal CDBQ      : std_logic_vector (4 downto 0);
    signal CDBV      : std_logic_vector (31 downto 0);
    signal Tag       : std_logic_vector (4 downto 0);
    signal WrEn      : std_logic;
    signal AddrW     : std_logic_vector (4 downto 0);
    signal Clk       : std_logic;
    signal Rst       : std_logic;
    signal DataOut1  : std_logic_vector (31 downto 0);
    signal DataOut2  : std_logic_vector (31 downto 0);

    constant TbPeriod : time := 1000 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : RegisterFile
    port map (ReadAddr1 => ReadAddr1,
              ReadAddr2 => ReadAddr2,
              CDBQ      => CDBQ,
              CDBV      => CDBV,
              Tag       => Tag,
              WrEn      => WrEn,
              AddrW     => AddrW,
              Clk       => Clk,
              Rst       => Rst,
              DataOut1  => DataOut1,
              DataOut2  => DataOut2);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that Clk is really your main clock signal
    Clk <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        ReadAddr1 <= (others => '0');
        ReadAddr2 <= (others => '0');
        CDBQ <= (others => '0');
        CDBV <= (others => '0');
        Tag <= (others => '0');
        WrEn <= '0';
        AddrW <= (others => '0');

        -- Reset generation
        -- EDIT: Check that Rst is really your reset signal
        Rst <= '1';
        wait for 100 ns;
        Rst <= '0';
        wait for 100 ns;

        -- EDIT Add stimuli here
        wait for 100 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;
end tb;