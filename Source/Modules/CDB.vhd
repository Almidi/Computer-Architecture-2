library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity CDB is
    Port ( QArithmetic : in STD_LOGIC_VECTOR (4 downto 0);
           VArithmetic : in STD_LOGIC_VECTOR (31 downto 0);
           QLogical : in STD_LOGIC_VECTOR (4 downto 0);
           VLogical : in STD_LOGIC_VECTOR (31 downto 0);
           QBuffer : in STD_LOGIC_VECTOR (4 downto 0);
           VBuffer : in STD_LOGIC_VECTOR (31 downto 0);
           ArithmeticRequest : in STD_LOGIC;
           LogicalRequest : in STD_LOGIC;
           BufferRequest : in STD_LOGIC;
           Clk : in STD_LOGIC;
           Rst : in STD_LOGIC;
           Qout : out STD_LOGIC_VECTOR (4 downto 0);
           Vout : out STD_LOGIC_VECTOR (31 downto 0);
           GrantArithmetic: out STD_LOGIC;
           GrantLogical: out STD_LOGIC;
           GrantBuffer: out STD_LOGIC);
end CDB;
architecture Behavioral of CDB is
	signal priority, selected: std_logic_vector(1 downto 0);
begin
--	process(Clk, Rst, ArithmeticRequest, LogicalRequest, BufferRequest,
--		VArithmetic, VLogical, VBuffer, QArithmetic, QLogical, QBuffer)
	process(Clk, Rst)
	begin
		if Rst='1' then
			Qout<=std_logic_vector(to_unsigned(0,5));
			Vout<=std_logic_vector(to_unsigned(0,32));
			priority<="00";
			GrantArithmetic<='0';
			GrantLogical<='0';
   			GrantBuffer<='0';
   			selected<="00";
		elsif rising_edge(clk) then
--		elsif clk = '1' then
--		else
			if selected="01" then
				Qout<=QArithmetic;
				Vout<=VArithmetic;
			elsif selected="10" then
				Qout<=QLogical;
				Vout<=VLogical;
			elsif selected="11" then
				Qout<=QBuffer;
				Vout<=VBuffer;
			else
				Qout<=std_logic_vector(to_unsigned(0,5));
				Vout<=std_logic_vector(to_unsigned(0,32));
			end if;
			--if Clk='1' then
				if priority="00" then
					if ArithmeticRequest='1' then
						selected<="01";
						GrantArithmetic<='1';
						GrantLogical<='0';
						GrantBuffer<='0';
						priority<="01";
					elsif LogicalRequest='1' then
						selected<="10";
						GrantArithmetic<='0';
						GrantLogical<='1';
						GrantBuffer<='0';
						priority<="01";
					elsif BufferRequest='1' then
						selected<="11";
						GrantArithmetic<='0';
						GrantLogical<='0';
						GrantBuffer<='1';
						priority<="01";
					else
						selected<="00";
						GrantArithmetic<='0';
						GrantLogical<='0';
						GrantBuffer<='0';
					end if;
				elsif priority="01" then
					if LogicalRequest='1' then
						selected<="10";
						GrantArithmetic<='0';
						GrantLogical<='1';
						GrantBuffer<='0';
						priority<="10";
					elsif BufferRequest='1' then
						selected<="11";
						GrantArithmetic<='0';
						GrantLogical<='0';
						GrantBuffer<='1';
						priority<="10";
					elsif ArithmeticRequest='1' then
						selected<="01";
						GrantArithmetic<='1';
						GrantLogical<='0';
						GrantBuffer<='0';
						priority<="10";
					else
						selected<="00";
						GrantArithmetic<='0';
						GrantLogical<='0';
						GrantBuffer<='0';
					end if;
				else
					if BufferRequest='1' then
						selected<="11";
						GrantArithmetic<='0';
						GrantLogical<='0';
						GrantBuffer<='1';
						priority<="00";
					elsif ArithmeticRequest='1' then
						selected<="01";
						GrantArithmetic<='1';
						GrantLogical<='0';
						GrantBuffer<='0';
						priority<="00";
					elsif LogicalRequest='1' then
						selected<="10";
						GrantArithmetic<='0';
						GrantLogical<='1';
						GrantBuffer<='0';
						priority<="00";
					else
						selected<="00";
						GrantArithmetic<='0';
						GrantLogical<='0';
						GrantBuffer<='0';
					end if;
				end if;
			--end if;
		end if;
	end process;
end Behavioral;