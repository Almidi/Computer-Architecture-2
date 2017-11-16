

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity TOP is
Port ( 
		IssueIn 	: in STD_LOGIC;
		FUType 		: in STD_LOGIC_VECTOR (1 downto 0);
		Fop 		: in STD_LOGIC_VECTOR (1 downto 0);
		Ri 			: in STD_LOGIC_VECTOR (4 downto 0);
		Rj 			: in STD_LOGIC_VECTOR (4 downto 0);
		Rk 			: in STD_LOGIC_VECTOR (4 downto 0);
		Accepted 	: out STD_LOGIC;
		Clk 		: in STD_LOGIC;
		Rst 		: in STD_LOGIC);  
end TOP;

architecture Behavioral of TOP is

component IssueUnit is
	Port ( 
		IssueIn 			: in STD_LOGIC;
		FUType 				: in STD_LOGIC_VECTOR (1 downto 0);
		Fop 				: in STD_LOGIC_VECTOR (1 downto 0);
		Ri 					: in STD_LOGIC_VECTOR (4 downto 0);
		Rj 					: in STD_LOGIC_VECTOR (4 downto 0);
		Rk 					: in STD_LOGIC_VECTOR (4 downto 0);
		RFReadAddr1 		: out STD_LOGIC_VECTOR (4 downto 0);
		RFReadAddr2 		: out STD_LOGIC_VECTOR (4 downto 0);
		RFTag 				: out STD_LOGIC_VECTOR (4 downto 0);
		RFAddrW 			: out STD_LOGIC_VECTOR (4 downto 0);
		RFWrEn 				: out STD_LOGIC;
		Accepted 			: out STD_LOGIC;
		OpOut 				: out STD_LOGIC_VECTOR (1 downto 0);
		ArithmeticAvailable : in STD_LOGIC_VECTOR (2 downto 0);
		ArithmeticIssue 	: out STD_LOGIC;
		LogicalAvailable 	: in STD_LOGIC_VECTOR (2 downto 0);
		LogicalIssue 		: out STD_LOGIC;
		Clk 				: in STD_LOGIC;
		Rst 				: in STD_LOGIC);   
end component;

component Arithmetic is
    Port ( RST 			: in STD_LOGIC;
           CLK 			: in STD_LOGIC;
           Issue 		: in STD_LOGIC;
           Op 			: in STD_LOGIC_VECTOR (1 downto 0);
           Vj 			: in STD_LOGIC_VECTOR (31 downto 0);
           Vk 			: in STD_LOGIC_VECTOR (31 downto 0);
           Qj 			: in STD_LOGIC_VECTOR (4 downto 0);
           Qk 			: in STD_LOGIC_VECTOR (4 downto 0);
           CDBV 		: in STD_LOGIC_VECTOR (31 downto 0);
           CDBQ 		: in STD_LOGIC_VECTOR (4 downto 0);
           Grant 		: in STD_LOGIC;
           Available 	: out STD_LOGIC_VECTOR(2 downto 0);
           VOut 		: out STD_LOGIC_VECTOR (31 downto 0);
           QOut 		: out STD_LOGIC_VECTOR (4 downto 0);
           RequestOut 	: out STD_LOGIC);
end component;

component Logical is
    Port ( RST 			: in STD_LOGIC;
           CLK 			: in STD_LOGIC;
           Issue 		: in STD_LOGIC;
           Op 			: in STD_LOGIC_VECTOR (1 downto 0);
           Vj 			: in STD_LOGIC_VECTOR (31 downto 0);
           Vk 			: in STD_LOGIC_VECTOR (31 downto 0);
           Qj 			: in STD_LOGIC_VECTOR (4 downto 0);
           Qk 			: in STD_LOGIC_VECTOR (4 downto 0);
           CDBV 		: in STD_LOGIC_VECTOR (31 downto 0);
           CDBQ 		: in STD_LOGIC_VECTOR (4 downto 0);
           Grant 		: in STD_LOGIC;
           Available 	: out STD_LOGIC_VECTOR(2 downto 0);
           VOut 		: out STD_LOGIC_VECTOR (31 downto 0);
           QOut 		: out STD_LOGIC_VECTOR (4 downto 0);
           RequestOut 	: out STD_LOGIC);
end component;

component RegisterFile is
    Port ( ReadAddr1 	: in STD_LOGIC_VECTOR (4 downto 0);
           ReadAddr2 	: in STD_LOGIC_VECTOR (4 downto 0);
           CDBQ 		: in STD_LOGIC_VECTOR (4 downto 0);
           CDBV 		: in STD_LOGIC_VECTOR (31 downto 0);
           Tag 			: in STD_LOGIC_VECTOR (4 downto 0);
           WrEn 		: in STD_LOGIC;
           AddrW 		: in STD_LOGIC_VECTOR (4 downto 0);
           Clk 			: in STD_LOGIC;
           Rst 			: in STD_LOGIC;
           DataOut1 	: out STD_LOGIC_VECTOR (31 downto 0);
           TagOut1 		: out STD_LOGIC_VECTOR (4 downto 0);
           DataOut2 	: out STD_LOGIC_VECTOR (31 downto 0);
           TagOut2 		: out STD_LOGIC_VECTOR (4 downto 0));
end component;

component CDB is
    Port ( QArithmetic 			: in STD_LOGIC_VECTOR (4 downto 0);
           VArithmetic 			: in STD_LOGIC_VECTOR (31 downto 0);
           QLogical 			: in STD_LOGIC_VECTOR (4 downto 0);
           VLogical 			: in STD_LOGIC_VECTOR (31 downto 0);
           QBuffer 				: in STD_LOGIC_VECTOR (4 downto 0);
           VBuffer 				: in STD_LOGIC_VECTOR (31 downto 0);
           ArithmeticRequest 	: in STD_LOGIC;
           LogicalRequest 		: in STD_LOGIC;
           BufferRequest 		: in STD_LOGIC;
           Clk 					: in STD_LOGIC;
           Rst 					: in STD_LOGIC;
           Qout 				: out STD_LOGIC_VECTOR (4 downto 0);
           Vout 				: out STD_LOGIC_VECTOR (31 downto 0);
           GrantArithmetic		: out STD_LOGIC;
           GrantLogical			: out STD_LOGIC;
           GrantBuffer			: out STD_LOGIC);
end component;

-- Signals Of Component Outputs ---------------------------------------

-- IssueUnit Signals :
SIGNAL IssueUnit_RFReadAddr1		:STD_LOGIC_VECTOR (4 downto 0);
SIGNAL IssueUnit_RFReadAddr2		:STD_LOGIC_VECTOR (4 downto 0);
SIGNAL IssueUnit_RFTag				:STD_LOGIC_VECTOR (4 downto 0);
SIGNAL IssueUnit_RFAddrW			:STD_LOGIC_VECTOR (4 downto 0);
SIGNAL IssueUnit_RFWrEn				:STD_LOGIC;
SIGNAL IssueUnit_Accepted			:STD_LOGIC;
SIGNAL IssueUnit_OpOut 				:STD_LOGIC_VECTOR (1 downto 0);
SIGNAL IssueUnit_ArithmeticIssue 	:STD_LOGIC;
SIGNAL IssueUnit_LogicalIssue 		:STD_LOGIC;

--Arithmetic Signals
SIGNAL Arithmetic_Available 		:STD_LOGIC_VECTOR(2 downto 0);
SIGNAL Arithmetic_VOut 				:STD_LOGIC_VECTOR (31 downto 0);
SIGNAL Arithmetic_QOut 				:STD_LOGIC_VECTOR (4 downto 0);
SIGNAL Arithmetic_RequestOut 		:STD_LOGIC;

--Logical Signals
SIGNAL Logical_Available 			:STD_LOGIC_VECTOR(2 downto 0);
SIGNAL Logical_VOut 				:STD_LOGIC_VECTOR (31 downto 0);
SIGNAL Logical_QOut 				:STD_LOGIC_VECTOR (4 downto 0);
SIGNAL Logical_RequestOut 			:STD_LOGIC;

--Register File Signals
SIGNAL RF_DataOut1 					:STD_LOGIC_VECTOR (31 downto 0);
SIGNAL RF_TagOut1					:STD_LOGIC_VECTOR (4 downto 0);
SIGNAL RF_DataOut2 					:STD_LOGIC_VECTOR (31 downto 0);
SIGNAL RF_TagOut2					:STD_LOGIC_VECTOR (4 downto 0);

--CDB Signals

SIGNAL CDB_Qout 					:STD_LOGIC_VECTOR (4 downto 0);
SIGNAL CDB_Vout 					:STD_LOGIC_VECTOR (31 downto 0);
SIGNAL CDB_GrantArithmetic			:STD_LOGIC;
SIGNAL CDB_GrantLogical				:STD_LOGIC;
SIGNAL CDB_GrantBuffer				:STD_LOGIC;

-- Temps
SIGNAL CDB_BufferRequest 				:STD_LOGIC;
SIGNAL CDB_QBuffer 						:STD_LOGIC_VECTOR (4 downto 0);
SIGNAL CDB_VBuffer 						:STD_LOGIC_VECTOR (31 downto 0);

begin

 IU : IssueUnit port map ( 
		IssueIn 			=> IssueIn,
		FUType 				=> FUType,
		Fop 				=> Fop,
		Ri 					=> Ri,
		Rj 					=> Rj,
		Rk 					=> Rk,
		RFReadAddr1 		=> IssueUnit_RFReadAddr1,
		RFReadAddr2 		=> IssueUnit_RFReadAddr2,
		RFTag 				=> IssueUnit_RFTag,
		RFAddrW 			=> IssueUnit_RFAddrW,
		RFWrEn 				=> IssueUnit_RFWrEn,
		Accepted 			=> IssueUnit_Accepted,
		OpOut 				=> IssueUnit_OpOut,
		ArithmeticAvailable => Arithmetic_Available,
		ArithmeticIssue 	=> IssueUnit_ArithmeticIssue,
		LogicalAvailable 	=> Logical_Available,
		LogicalIssue 		=> IssueUnit_LogicalIssue,
		Clk 				=> CLK,
		Rst 				=> RST);   

Accepted <= IssueUnit_Accepted ;

 A : Arithmetic Port Map (
    	   RST 			=> RST,
           CLK 			=> CLK,
           Issue 		=> IssueUnit_ArithmeticIssue ,
           Op 			=> IssueUnit_OpOut,
           Vj 			=> RF_DataOut1,
           Vk 			=> RF_DataOut2,
           Qj 			=> RF_TagOut1,
           Qk 			=> RF_TagOut2,
           CDBV 		=> CDB_Vout,
           CDBQ 		=> CDB_Qout,
           Grant 		=> CDB_GrantArithmetic,
           Available 	=> Arithmetic_Available,
           VOut 		=> Arithmetic_VOut,
           QOut 		=> Arithmetic_QOut,
           RequestOut 	=> Arithmetic_RequestOut);


 L : Logical Port map (
     	   RST 			=> RST,
           CLK 			=> CLK,
           Issue 		=> IssueUnit_LogicalIssue,
           Op 			=> IssueUnit_OpOut,
           Vj 			=> RF_DataOut1,
           Vk 			=> RF_DataOut2,
           Qj 			=> RF_TagOut1,
           Qk 			=> RF_TagOut2,
           CDBV 		=> CDB_Vout,
           CDBQ 		=> CDB_Qout,
           Grant 		=> CDB_GrantLogical,
           Available 	=> Logical_Available,
           VOut 		=> Logical_VOut,
           QOut 		=> Logical_QOut,
           RequestOut 	=> Logical_RequestOut);


RF : RegisterFile port Map (
    	   ReadAddr1 	=> IssueUnit_RFReadAddr1,
           ReadAddr2 	=> IssueUnit_RFReadAddr2,
           CDBQ 		=> CDB_Qout,
           CDBV 		=> CDB_Vout,
           Tag 			=> IssueUnit_RFTag,
           WrEn 		=> IssueUnit_RFWrEn,
           AddrW 		=> IssueUnit_RFAddrW,
           Clk 			=> Clk,
           Rst 			=> Rst,
           DataOut1 	=> RF_DataOut1,
           TagOut1 		=> RF_TagOut1,
           DataOut2 	=> RF_DataOut2,
           TagOut2 		=> RF_TagOut2);

CDBC : CDB port map (
    	   QArithmetic 			=> Arithmetic_QOut,
           VArithmetic 			=> Arithmetic_VOut,
           QLogical 			=> Logical_QOut,
           VLogical 			=> Logical_VOut,
           QBuffer 				=> CDB_QBuffer,
           VBuffer 				=> CDB_VBuffer,
           ArithmeticRequest 	=> Arithmetic_RequestOut,
           LogicalRequest 		=> Logical_RequestOut,
           BufferRequest 		=> CDB_BufferRequest,
           Clk 					=> Clk,
           Rst 					=> Rst,
           Qout 				=> CDB_Qout,
           Vout 				=> CDB_Vout,
           GrantArithmetic		=> CDB_GrantArithmetic,
           GrantLogical			=> CDB_GrantLogical,
           GrantBuffer			=> CDB_GrantBuffer);

CDB_QBuffer <= "00000";
CDB_VBuffer <= "00000000000000000000000000000000";
CDB_BufferRequest <= '0';


end Behavioral;
