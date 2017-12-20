library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity ReorderBufferBlock is
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
		ExceptionOut: out std_logic;
		);
end ReorderBufferBlock;
architecture Structural of ReorderBufferBlock is
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
	      
	      component Register2 is
		Port ( DataIn : in STD_LOGIC_VECTOR (1 downto 0);
		       WrEn : in STD_LOGIC;
		       Rst : in STD_LOGIC;
		       Clk : in STD_LOGIC;
		       DataOut : out STD_LOGIC_VECTOR (1 downto 0));
	      end component;
	      
	      component Register1 is
		Port ( DataIn : in STD_LOGIC;
		       WrEn : in STD_LOGIC;
		       Rst : in STD_LOGIC;
		       Clk : in STD_LOGIC;
		       DataOut : out STD_LOGIC);
	      end component;

	      component CompareModule is
		Port ( In0 : in  STD_LOGIC_VECTOR (4 downto 0);
		       In1 : in  STD_LOGIC_VECTOR (4 downto 0);
		       DOUT : out  STD_LOGIC);
	      end component;

	signal ComparatorOut: std_logic;
	signal tagSignal: std_logic_vector(4 downto 0);

begin
	InstrTypeREG : Register2 Port Map ( DataIn =>InstrTypeIn,
							WrEn =>WrEn,
							Clk =>Clk,
							DataOut =>InstrTypeOut,
							Rst =>Rst);

	DestinationREG : Register5 Port Map ( 	  DataIn =>DestinationIn,
								WrEn =>WrEn,
								Clk =>Clk,
								DataOut =>DestinationOut,
								Rst =>Rst);

	TagREG : Register5 Port Map ( DataIn =>TagIn,
						WrEn =>WrEn,
						Clk =>Clk,
						DataOut =>tagSignal,
						Rst =>Rst);
	TagOut<=tagSignal;

	comparator: CompareModule port map(In0=>CDBQ,In1=>tagSignal,DOUT=>ComparatorOut);

	ValueREG : Register32 Port Map (     DataIn =>CDBV,
							WrEn =>ComparatorOut,
							Clk =>Clk,
							DataOut =>ValueOut,
							Rst =>Rst);

	PCREG : Register32 Port Map ( DataIn =>PCIn,
						WrEn =>WrEn,
						Clk =>Clk,
						DataOut =>PCOut,
						Rst =>Rst);

	ReadyREG : Register1 Port Map (    DataIn =>'1',
							WrEn =>ComparatorOut,
							Clk =>Clk,
							DataOut =>ReadyOut,
							Rst =>Rst);
	
	ExceptionREG : Register1 Port Map (    	   DataIn =>'1',
								WrEn =>ExceptionIn,
								Clk =>Clk,
								DataOut =>ExceptionOut,
								Rst =>Rst);
end Structural;