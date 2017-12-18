library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity tb_CDB is
end tb_CDB;
architecture tb of tb_CDB is
component CDB
        port (QArithmetic       : in std_logic_vector (4 downto 0);
              VArithmetic       : in std_logic_vector (31 downto 0);
              QLogical          : in std_logic_vector (4 downto 0);
              VLogical          : in std_logic_vector (31 downto 0);
              QBuffer           : in std_logic_vector (4 downto 0);
              VBuffer           : in std_logic_vector (31 downto 0);
              ArithmeticRequest : in std_logic;
              LogicalRequest    : in std_logic;
              BufferRequest     : in std_logic;
              Clk               : in std_logic;
              Rst               : in std_logic;
              Qout              : out std_logic_vector (4 downto 0);
              Vout              : out std_logic_vector (31 downto 0));
    end component;

    signal QArithmetic       : std_logic_vector (4 downto 0);
    signal VArithmetic       : std_logic_vector (31 downto 0);
    signal QLogical          : std_logic_vector (4 downto 0);
    signal VLogical          : std_logic_vector (31 downto 0);
    signal QBuffer           : std_logic_vector (4 downto 0);
    signal VBuffer           : std_logic_vector (31 downto 0);
    signal ArithmeticRequest : std_logic;
    signal LogicalRequest    : std_logic;
    signal BufferRequest     : std_logic;
    signal Clk               : std_logic;
    signal Rst               : std_logic;
    signal Qout              : std_logic_vector (4 downto 0);
    signal Vout              : std_logic_vector (31 downto 0);

    constant TbPeriod : time := 10 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : CDB
    port map (QArithmetic       => QArithmetic,
              VArithmetic       => VArithmetic,
              QLogical          => QLogical,
              VLogical          => VLogical,
              QBuffer           => QBuffer,
              VBuffer           => VBuffer,
              ArithmeticRequest => ArithmeticRequest,
              LogicalRequest    => LogicalRequest,
              BufferRequest     => BufferRequest,
              Clk               => Clk,
              Rst               => Rst,
              Qout              => Qout,
              Vout              => Vout);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that Clk is really your main clock signal
    Clk <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        QArithmetic <= (others => '0');
        VArithmetic <= (others => '0');
        QLogical <= (others => '0');
        VLogical <= (others => '0');
        QBuffer <= (others => '0');
        VBuffer <= (others => '0');
        ArithmeticRequest <= '0';
        LogicalRequest <= '0';
        BufferRequest <= '0';

        -- Reset generation
        -- EDIT: Check that Rst is really your reset signal
        Rst <= '1';
        wait for 100 ns;
        Rst <= '0';
        wait for 100 ns;

        -- EDIT Add stimuli here
        QArithmetic <= "01001";
		VArithmetic <= std_logic_vector(to_unsigned(10,32));
		QLogical <= "01010";
		VLogical <= std_logic_vector(to_unsigned(20,32));
		QBuffer <= "01011";
		VBuffer <= std_logic_vector(to_unsigned(30,32));
		ArithmeticRequest <= '1';
		LogicalRequest <= '1';
		BufferRequest <= '1';
        wait for 100 ns;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;