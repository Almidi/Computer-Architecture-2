library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.Bus32pkg.ALL;
use IEEE.NUMERIC_STD.ALL;
entity RegisterFile is
    Port ( ReadAddr1 : in STD_LOGIC_VECTOR (4 downto 0);
           ReadAddr2 : in STD_LOGIC_VECTOR (4 downto 0);
           CDBQ : in STD_LOGIC_VECTOR (4 downto 0);
           CDBV : in STD_LOGIC_VECTOR (31 downto 0);
           Tag : in STD_LOGIC_VECTOR (4 downto 0);
           WrEn : in STD_LOGIC;
           AddrW : in STD_LOGIC_VECTOR (4 downto 0);
           Clk : in STD_LOGIC;
           Rst : in STD_LOGIC;
           DataOut1 : out STD_LOGIC_VECTOR (31 downto 0);
           TagOut1: out STD_LOGIC_VECTOR (4 downto 0);
           DataOut2 : out STD_LOGIC_VECTOR (31 downto 0);
           TagOut2: out STD_LOGIC_VECTOR (4 downto 0));
end RegisterFile;
architecture Structural of RegisterFile is
	component Register32 is
		Port ( DataIn : in STD_LOGIC_VECTOR (31 downto 0);
			   WrEn : in STD_LOGIC;
			   Clk : in STD_LOGIC;
			   DataOut : out STD_LOGIC_VECTOR (31 downto 0);
			   Rst : in STD_LOGIC);
	end component;
	component Register5 is
		Port ( DataIn : in STD_LOGIC_VECTOR (4 downto 0);
			   WrEn : in STD_LOGIC;
			   Rst : in STD_LOGIC;
			   Clk : in STD_LOGIC;
			   DataOut : out STD_LOGIC_VECTOR (4 downto 0));
	end component;
	component TagWrEnHandler is
		Port ( AddrW : in STD_LOGIC_VECTOR (4 downto 0);
			   WrEn : in STD_LOGIC;
			   Output : out STD_LOGIC_VECTOR (31 downto 0));
	end component;
	component BusMultiplexer32 is
	    Port (	Input : in Bus32;
				Sel : in  STD_LOGIC_VECTOR (4 downto 0);
				Output : out  STD_LOGIC_VECTOR (31 downto 0));
	end component;
	component BusMultiplexer32x5 is
	    Port (		Input : in Bus32x5;
					Sel : in  STD_LOGIC_VECTOR (4 downto 0);
					Output : out  STD_LOGIC_VECTOR (4 downto 0));
	end component;
	component CompareModule is
	    Port ( In0 : in  STD_LOGIC_VECTOR (4 downto 0);
	           In1 : in  STD_LOGIC_VECTOR (4 downto 0);
	           DOUT : out  STD_LOGIC);
	end component;
	
	signal register32Out : Bus32;
	signal register5Out: Bus32x5;
	signal TagResetBuffer: STD_LOGIC_VECTOR(31 downto 0);
	signal TagWrEnHandlerOut, ComparatorsOut, Register32WrEnSignal, TagRst: std_logic_vector(31 downto 0);
	signal isZero: std_logic;
begin

	TagResetBufferReg : Register32 Port Map
			( DataIn => TagRst ,
			   WrEn => '1',
			   Clk => Clk,
			   DataOut => TagResetBuffer,
			   Rst=>'0');

	register32_0: Register32 port map(DataIn=>CDBV, WrEn=>'0', Clk=>Clk, DataOut=>register32Out(0), Rst=>Rst);
	Register32Generator:
	for i in 1 to 31 generate
		register32_i: Register32 port map(DataIn=>CDBV, WrEn=>Register32WrEnSignal(i), Clk=>Clk, DataOut=>register32Out(i), Rst=>Rst);
	end generate;
	TagRstGenerator:
	for i in 0 to 31 generate
		TagRst(i)<=Rst or Register32WrEnSignal(i);
	end generate;
	Register5Generator:
	for i in 0 to 31 generate
		register5_i: Register5 port map(DataIn=>Tag, WrEn=>TagWrEnHandlerOut(i), Clk=>Clk, DataOut=>register5Out(i), Rst=>TagResetBuffer(i));
	end generate;
	BusMux32_DataOut1: BusMultiplexer32 port map(Input=>register32Out, Sel=>ReadAddr1, Output=>DataOut1);
	BusMux32x5_TagOut1: BusMultiplexer32x5 port map(Input=>register5Out, Sel=>ReadAddr1, Output=>TagOut1);
	BusMux32_DataOut2: BusMultiplexer32 port map(Input=>register32Out, Sel=>ReadAddr2, Output=>DataOut2);
	BusMux32x5_TagOut2: BusMultiplexer32x5 port map(Input=>register5Out, Sel=>ReadAddr2, Output=>TagOut2);
	TagWrEnHandler_0: TagWrEnHandler port map(AddrW=>AddrW,WrEn=>WrEn,Output=>TagWrEnHandlerOut);
	ComparatorsGenerators:
	for i in 0 to 31 generate
		comparator_i: CompareModule port map(In0=>CDBQ,In1=>register5Out(i),DOUT=>ComparatorsOut(i));
	end generate;
	CompareToZero: CompareModule port map(In0=>CDBQ,In1=>std_logic_vector(to_unsigned(0,5)),DOUT=>isZero);
	Register32WrEnGenerator:
	for i in 0 to 31 generate
		Register32WrEnSignal(i)<=ComparatorsOut(i) and not isZero;
	end generate;
end Structural;