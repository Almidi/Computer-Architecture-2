library ieee;
use ieee.std_logic_1164.all;

entity tb_ReorderBufferBlock is
end tb_ReorderBufferBlock;

architecture tb of tb_ReorderBufferBlock is

    component ReorderBufferBlock
        port (InstrTypeIn    : in std_logic_vector (1 downto 0);
              DestinationIn  : in std_logic_vector (4 downto 0);
              TagIn          : in std_logic_vector (4 downto 0);
              PCIn           : in std_logic_vector (31 downto 0);
              ExceptionIn    : in std_logic;
              CDBQ           : in std_logic_vector (4 downto 0);
              CDBV           : in std_logic_vector (31 downto 0);
              WrEn           : in std_logic;
              Clk            : in std_logic;
              Rst            : in std_logic;
              InstrTypeOut   : out std_logic_vector (1 downto 0);
              DestinationOut : out std_logic_vector (4 downto 0);
              TagOut         : out std_logic_vector (4 downto 0);
              ValueOut       : out std_logic_vector (31 downto 0);
              PCOut          : out std_logic_vector (31 downto 0);
              ReadyOut       : out std_logic;
              ExceptionOut   : out std_logic);
    end component;

    signal InstrTypeIn    : std_logic_vector (1 downto 0);
    signal DestinationIn  : std_logic_vector (4 downto 0);
    signal TagIn          : std_logic_vector (4 downto 0);
    signal PCIn           : std_logic_vector (31 downto 0);
    signal ExceptionIn    : std_logic;
    signal CDBQ           : std_logic_vector (4 downto 0);
    signal CDBV           : std_logic_vector (31 downto 0);
    signal WrEn           : std_logic;
    signal Clk            : std_logic;
    signal Rst            : std_logic;
    signal InstrTypeOut   : std_logic_vector (1 downto 0);
    signal DestinationOut : std_logic_vector (4 downto 0);
    signal TagOut         : std_logic_vector (4 downto 0);
    signal ValueOut       : std_logic_vector (31 downto 0);
    signal PCOut          : std_logic_vector (31 downto 0);
    signal ReadyOut       : std_logic;
    signal ExceptionOut   : std_logic;

    constant TbPeriod : time := 10 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : ReorderBufferBlock
    port map (InstrTypeIn    => InstrTypeIn,
              DestinationIn  => DestinationIn,
              TagIn          => TagIn,
              PCIn           => PCIn,
              ExceptionIn    => ExceptionIn,
              CDBQ           => CDBQ,
              CDBV           => CDBV,
              WrEn           => WrEn,
              Clk            => Clk,
              Rst            => Rst,
              InstrTypeOut   => InstrTypeOut,
              DestinationOut => DestinationOut,
              TagOut         => TagOut,
              ValueOut       => ValueOut,
              PCOut          => PCOut,
              ReadyOut       => ReadyOut,
              ExceptionOut   => ExceptionOut);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that Clk is really your main clock signal
    Clk <= TbClock;

    stimuli : process
    begin

        wait for  TbPeriod/2 ;
        -- EDIT Adapt initialization as needed
        InstrTypeIn <= (others => '0');
        DestinationIn <= (others => '0');
        TagIn <= (others => '0');
        PCIn <= (others => '0');
        ExceptionIn <= '0';
        CDBQ <= (others => '0');
        CDBV <= (others => '0');
        WrEn <= '0';

        -- Reset generation
        -- EDIT: Check that Rst is really your reset signal
        Rst <= '1';
        wait for 100 ns;
        Rst <= '0';
        wait for 100 ns;

        InstrTypeIn <= "10";
        DestinationIn <= "00110";
        TagIn <= "10010";
        PCIn <= "00000000000000000000000010000000";
        ExceptionIn <= '0';
        WrEn <= '1';

        wait for 1 * TbPeriod;        
        WrEn <= '0';
        wait for 1*TbPeriod;

        CDBV <= "00000000000000000000000000111001";
        CDBQ <= "10010";

        wait for 2*TbPeriod;

        CDBQ <= (others => '0');
        CDBV <= (others => '0');

        wait for 6*TbPeriod;

        ExceptionIn <= '1';
        wait for 1 * TbPeriod;        
        ExceptionIn <= '0';
        wait for 3 * TbPeriod;  

        Rst <= '1';
        wait for 100 ns;
        Rst <= '0';
        wait for 100 ns;

        InstrTypeIn <= "10";
        DestinationIn <= "00110";
        TagIn <= "10010";
        PCIn <= "00000000000000000000000010000000";
        ExceptionIn <= '0';
        WrEn <= '1';
        CDBV <= "00000000000000000000000000111001";
        CDBQ <= "10010";
        --ExceptionIn <= '1';

        wait for 1 * TbPeriod;        
        WrEn <= '0';
        --wait for 1*TbPeriod;
        ExceptionIn <= '0';
        CDBQ <= (others => '0');
        CDBV <= (others => '0');
        wait for 1*TbPeriod;


        -- EDIT Add stimuli here
        wait for 100 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;