library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity tb_Memory is
end tb_Memory;
architecture tb of tb_Memory is
    component Memory
        port (DataIn    : in std_logic_vector (31 downto 0);
              WriteAddr : in std_logic_vector (4 downto 0);
              WrEn      : in std_logic;
              ReadAddr  : in std_logic_vector (4 downto 0);
              Tag       : in std_logic_vector (4 downto 0);
              Grant     : in std_logic;
              Clk       : in std_logic;
              Rst       : in std_logic;
              Busy      : out std_logic;
              Request   : out std_logic;
              VOut      : out std_logic_vector (31 downto 0);
              QOut      : out std_logic_vector (4 downto 0));
    end component;

    signal DataIn    : std_logic_vector (31 downto 0);
    signal WriteAddr : std_logic_vector (4 downto 0);
    signal WrEn      : std_logic;
    signal ReadAddr  : std_logic_vector (4 downto 0);
    signal Tag       : std_logic_vector (4 downto 0);
    signal Grant     : std_logic;
    signal Clk       : std_logic;
    signal Rst       : std_logic;
    signal Busy      : std_logic;
    signal Request   : std_logic;
    signal VOut      : std_logic_vector (31 downto 0);
    signal QOut      : std_logic_vector (4 downto 0);

    constant TbPeriod : time := 10 ns;
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';
begin
    dut : Memory
    port map (DataIn    => DataIn,
              WriteAddr => WriteAddr,
              WrEn      => WrEn,
              ReadAddr  => ReadAddr,
              Tag       => Tag,
              Grant     => Grant,
              Clk       => Clk,
              Rst       => Rst,
              Busy      => Busy,
              Request   => Request,
              VOut      => VOut,
              QOut      => QOut);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';
    Clk <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        DataIn <= (others => '0');
        WriteAddr <= (others => '0');
        WrEn <= '0';
        ReadAddr <= (others => '0');
        Tag <= (others => '0');
        Grant <= '0';

        -- Reset generation
        Rst <= '1';
		wait for 1 * TbPeriod;
        Rst <= '0';
        wait for 1.5 * TbPeriod;

		-- EDIT Add stimuli here
		FillMemory:
		for i in 0 to 32 loop
			DataIn 		<= std_logic_vector(to_unsigned(i,32));
			WriteAddr 	<= std_logic_vector(to_unsigned(i,5));
			WrEn 		<= '1';
			Tag 		<= std_logic_vector(to_unsigned(i+1,5));
			Grant 		<= '1';
			wait for 1 * TbPeriod;
		end loop;

		-- Nops
		DataIn 		<= std_logic_vector(to_unsigned(0,32));
		WriteAddr 	<= std_logic_vector(to_unsigned(0,5));
		WrEn 		<= '0';
		Tag 		<= std_logic_vector(to_unsigned(0,5));
		wait for 5 * TbPeriod;
		
		ReadMemory:
		for i in 0 to 32 loop
			ReadAddr	<= std_logic_vector(to_unsigned(i,5));
			Tag 		<= std_logic_vector(to_unsigned(i+1,5));
			Grant 		<= '1';
			wait for 1 * TbPeriod;
		end loop;
        wait;
    end process;
end tb;