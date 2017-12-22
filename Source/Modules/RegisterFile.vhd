library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.Bus32pkg.ALL;
use IEEE.NUMERIC_STD.ALL;
entity RegisterFile is
	Port( ReadAddr1 : in STD_LOGIC_VECTOR (4 downto 0);
		ReadAddr2 : in STD_LOGIC_VECTOR (4 downto 0);
		AddrW : in STD_LOGIC_VECTOR (4 downto 0);
		RFWrData : in STD_LOGIC_VECTOR (31 downto 0);
		WrEn : in STD_LOGIC;
		Clk : in STD_LOGIC;
		Rst : in STD_LOGIC;
		DataOut1 : out STD_LOGIC_VECTOR (31 downto 0);
		DataOut2 : out STD_LOGIC_VECTOR (31 downto 0));
end RegisterFile;
architecture Structural of RegisterFile is
	component Register32 is
		Port ( DataIn : in STD_LOGIC_VECTOR (31 downto 0);
			WrEn : in STD_LOGIC;
			Clk : in STD_LOGIC;
			DataOut : out STD_LOGIC_VECTOR (31 downto 0);
			Rst : in STD_LOGIC);
	end component;
	component BusMultiplexer32 is
		Port (Input : in Bus32;
			Sel : in  STD_LOGIC_VECTOR (4 downto 0);
			Output : out  STD_LOGIC_VECTOR (31 downto 0));
	end component;
<<<<<<< HEAD
	component BusMultiplexer32x5 is
	    Port (		Input : in Bus32x5;
					Sel : in  STD_LOGIC_VECTOR (4 downto 0);
					Output : out  STD_LOGIC_VECTOR (4 downto 0));
	end component;
	component CompareModuleNonZero is
	    Port ( In0 : in  STD_LOGIC_VECTOR (4 downto 0);
	           In1 : in  STD_LOGIC_VECTOR (4 downto 0);
	           DOUT : out  STD_LOGIC);
=======
	component Decoder5to32 is
		Port ( Input : in STD_LOGIC_VECTOR (4 downto 0);
		       Output : out STD_LOGIC_VECTOR (31 downto 0));
>>>>>>> 103104fd8e56fd9e31b7f5535a2bab9c10c30b8c
	end component;
	
	signal register32Out : Bus32;
	signal DecoderOut, RFWrEnSignal: std_logic_vector(31 downto 0);
begin
	decoder: Decoder5to32 Port map(Input=>AddrW, Output=>DecoderOut);
	register32Out(0)<=std_logic_vector(to_unsigned(0,32));
	RFWrEnSignal(0)<='0';
	Register32Generator:
	for i in 1 to 31 generate
		RFWrEnSignal(i)<=DecoderOut(i) and WrEn;
		register32_i: Register32 port map(DataIn=>RFWrData, WrEn=>RFWrEnSignal(i), Clk=>Clk, DataOut=>register32Out(i), Rst=>Rst);
	end generate;
	BusMux32_DataOut1: BusMultiplexer32 port map(Input=>register32Out, Sel=>ReadAddr1, Output=>DataOut1);
	BusMux32_DataOut2: BusMultiplexer32 port map(Input=>register32Out, Sel=>ReadAddr2, Output=>DataOut2);
<<<<<<< HEAD
	BusMux32x5_TagOut2: BusMultiplexer32x5 port map(Input=>register5Out, Sel=>ReadAddr2, Output=>TagOut2);
	TagWrEnHandler_0: TagWrEnHandler port map(AddrW=>AddrW,WrEn=>WrEn,Output=>TagWrEnHandlerOut);
	ComparatorsGenerators:
	for i in 0 to 31 generate
		comparator_i: CompareModuleNonZero port map(In0=>CDBQ,In1=>register5Out(i),DOUT=>ComparatorsOut(i));
	end generate;
	CompareToZero: CompareModuleNonZero port map(In0=>CDBQ,In1=>std_logic_vector(to_unsigned(0,5)),DOUT=>isZero);
	Register32WrEnGenerator:
	for i in 0 to 31 generate
		Register32WrEnSignal(i)<=ComparatorsOut(i) and not isZero;
	end generate;
=======
>>>>>>> 103104fd8e56fd9e31b7f5535a2bab9c10c30b8c
end Structural;