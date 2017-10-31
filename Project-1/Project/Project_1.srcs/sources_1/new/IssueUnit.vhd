library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;
entity IssueUnit is
    Port ( IssueIn : in STD_LOGIC;
           FUType : in STD_LOGIC_VECTOR (1 downto 0);
           Fop : in STD_LOGIC_VECTOR (1 downto 0);
           Ri : in STD_LOGIC_VECTOR (4 downto 0);
           Rj : in STD_LOGIC_VECTOR (4 downto 0);
           Rk : in STD_LOGIC_VECTOR (4 downto 0);
           Accepted : out STD_LOGIC;
           OpOut : out STD_LOGIC_VECTOR (1 downto 0);
           VjOut : out STD_LOGIC_VECTOR (31 downto 0);
           VkOut : out STD_LOGIC_VECTOR (31 downto 0);
           QjOut : out STD_LOGIC_VECTOR (4 downto 0);
           QkOut : out STD_LOGIC_VECTOR (4 downto 0);
           ArithmeticAvailable : in STD_LOGIC;
           ArithmeticIssue : out STD_LOGIC;
           LogicalAvailable : in STD_LOGIC;
           LogicalIssue : out STD_LOGIC);   
end IssueUnit;
architecture Behavioral of IssueUnit is
begin
	
end Behavioral;