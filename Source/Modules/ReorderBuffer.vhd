library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity ReorderBuffer is
	Port (InstrTypeIn: in std_logic_vector(1 downto 0);
		DestinationIn: in std_logic_vector(4 downto 0);
		TagIn: in std_logic_vector(4 downto 0);
		PCIn: in std_logic_vector(31 downto 0);
		ExceptionIn: in std_logic;
		CDBQ: in std_logic_vector(4 downto 0);
		CDBV: in std_logic_vector(31 downto 0);		
		WrEn: in std_logic;
		Clk: in std_logic;
		Rst: in std_logic);
end ReorderBuffer;
architecture Structural of ReorderBuffer is
	component ReorderBufferBlock
		Port (InstrTypeIn: in std_logic_vector(1 downto 0);
			DestinationIn: in std_logic_vector(4 downto 0);
			TagIn: in std_logic_vector(4 downto 0);
			PCIn: in std_logic_vector(31 downto 0);
			ExceptionIn: in std_logic;
			CDBQ: in std_logic_vector(4 downto 0);
			CDBV: in std_logic_vector(31 downto 0);		
			WrEn: in std_logic;
			Clk: in std_logic;
			Rst: in std_logic;
			InstrTypeOut: out std_logic_vector(1 downto 0);
			DestinationOut: out std_logic_vector(4 downto 0);
			TagOut: out std_logic_vector(4 downto 0);
			ValueOut: out std_logic_vector(31 downto 0);
			PCOut: out std_logic_vector(31 downto 0);
			ReadyOut: out std_logic;
			ExceptionOut: out std_logic);
	end component;

	component Counter4
		port( Enable: in std_logic;
			DataIn: in std_logic_vector(3 downto 0);
			Load: in std_logic;
			Clk: in std_logic;
			Rst: in std_logic;
			Output: out std_logic_vector(0 to 3));
	end component;
	
	signal HeadEnable, TailEnable, HeadLoad, TailLoad : std_logic;
	signal HeadDataIn, TailDataIn, HeadOutput, TailOutput: std_logic_vector(3 downto 0);

	type Bus16x2 is array (15 downto 0) of STD_LOGIC_VECTOR (1 downto 0);
	type Bus16x32 is array (15 downto 0) of STD_LOGIC_VECTOR (31 downto 0);
	type Bus16x5 is array (15 downto 0) of STD_LOGIC_VECTOR (4 downto 0);
	signal WrEnSignal, ReadyOutSignal, ExceptionOutSignal: std_logic_vector(15 downto 0);
	signal InstrTypeOutSignal: Bus16x2;
	signal DestinationOutSignal, TagOutSignal: Bus16x5;
	signal ValueOutSignal, PCOutSignal: Bus16x32;
begin
	ReorderBufferBlockGenerator:
	for i in 0 to 15 generate
		ReorderBufferBlock_i: ReorderBufferBlock port map(
			InstrTypeIn=>InstrTypeIn,
			DestinationIn=>DestinationIn,
			TagIn=>TagIn,
			PCIn=>PCIn,
			ExceptionIn=>ExceptionIn,
			CDBQ=>CDBQ,
			CDBV=>CDBV,
			WrEn=>WrEnSignal(i),
			Clk=>Clk,
			Rst=>Rst,
			InstrTypeOut=>InstrTypeOutSignal(i),
			DestinationOut=>DestinationOutSignal(i),
			TagOut=>TagOutSignal(i),
			ValueOut=>ValueOutSignal(i),
			PCOut=>PCOutSignal(i),
			ReadyOut=>ReadyOutSignal(i),
			ExceptionOut=>ExceptionOutSignal(i));
	end generate;

	Head: Counter4 port map (   Enable=>HeadEnable,
						DataIn=>HeadDataIn,
						Load=>HeadLoad,
						Clk=>Clk,
						Rst=>Rst,
						Output=>HeadOutput);

	Tail: Counter4 port map(Enable=>TailEnable,
					DataIn=>TailDataIn,
					Load=>TailLoad,
					Clk=>Clk,
					Rst=>Rst,
					Output=>TailOutput);
end Structural;