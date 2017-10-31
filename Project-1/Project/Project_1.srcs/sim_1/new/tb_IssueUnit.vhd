library ieee;
use ieee.std_logic_1164.all;
entity tb_IssueUnit is
end tb_IssueUnit;
architecture tb of tb_IssueUnit is
    component IssueUnit
        port (IssueIn             : in std_logic;
              FUType              : in std_logic_vector (1 downto 0);
              Fop                 : in std_logic_vector (1 downto 0);
              Ri                  : in std_logic_vector (4 downto 0);
              Rj                  : in std_logic_vector (4 downto 0);
              Rk                  : in std_logic_vector (4 downto 0);
              RFReadAddr1         : out std_logic_vector (4 downto 0);
              RFReadAddr2         : out std_logic_vector (4 downto 0);
              RFTag               : out std_logic_vector (4 downto 0);
              RFAddrW             : out std_logic_vector (4 downto 0);
              RFWrEn              : out std_logic;
              Accepted            : out std_logic;
              OpOut               : out std_logic_vector (1 downto 0);
              ArithmeticAvailable : in std_logic_vector (2 downto 0);
              ArithmeticIssue     : out std_logic;
              LogicalAvailable    : in std_logic_vector (2 downto 0);
              LogicalIssue        : out std_logic;
              Clk                 : in std_logic;
              Rst                 : in std_logic);
    end component;

    signal IssueIn             : std_logic;
    signal FUType              : std_logic_vector (1 downto 0);
    signal Fop                 : std_logic_vector (1 downto 0);
    signal Ri                  : std_logic_vector (4 downto 0);
    signal Rj                  : std_logic_vector (4 downto 0);
    signal Rk                  : std_logic_vector (4 downto 0);
    signal RFReadAddr1         : std_logic_vector (4 downto 0);
    signal RFReadAddr2         : std_logic_vector (4 downto 0);
    signal RFTag               : std_logic_vector (4 downto 0);
    signal RFAddrW             : std_logic_vector (4 downto 0);
    signal RFWrEn              : std_logic;
    signal Accepted            : std_logic;
    signal OpOut               : std_logic_vector (1 downto 0);
    signal ArithmeticAvailable : std_logic_vector (2 downto 0);
    signal ArithmeticIssue     : std_logic;
    signal LogicalAvailable    : std_logic_vector (2 downto 0);
    signal LogicalIssue        : std_logic;
    signal Clk                 : std_logic;
    signal Rst                 : std_logic;

    constant TbPeriod : time := 10 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin
    dut : IssueUnit
    port map (IssueIn             => IssueIn,
              FUType              => FUType,
              Fop                 => Fop,
              Ri                  => Ri,
              Rj                  => Rj,
              Rk                  => Rk,
              RFReadAddr1         => RFReadAddr1,
              RFReadAddr2         => RFReadAddr2,
              RFTag               => RFTag,
              RFAddrW             => RFAddrW,
              RFWrEn              => RFWrEn,
              Accepted            => Accepted,
              OpOut               => OpOut,
              ArithmeticAvailable => ArithmeticAvailable,
              ArithmeticIssue     => ArithmeticIssue,
              LogicalAvailable    => LogicalAvailable,
              LogicalIssue        => LogicalIssue,
              Clk                 => Clk,
              Rst                 => Rst);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that Clk is really your main clock signal
    Clk <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        IssueIn <= '0';
        FUType <= (others => '0');
        Fop <= (others => '0');
        Ri <= (others => '0');
        Rj <= (others => '0');
        Rk <= (others => '0');
        ArithmeticAvailable <= (others => '0');
        LogicalAvailable <= (others => '0');

        -- Reset generation
        -- EDIT: Check that Rst is really your reset signal
        Rst <= '1';
        wait for 100 ns;
        Rst <= '0';
        wait for 100 ns;

        -- EDIT Add stimuli here
		IssueIn<='1';
		FUType<="00";
		Fop<="00";
		Ri<="00001";
		Rj<="00010";
		Rk<="00011";
		ArithmeticAvailable<="001";
		LogicalAvailable<="001";
		wait for 100 ns;
        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;
end tb;