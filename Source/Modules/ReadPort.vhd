library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.Bus32pkg.ALL;
entity ReadPort is
	Port ( ReadAddr : in STD_LOGIC_VECTOR (4 downto 0);
		DestinationsIn: in Bus16x5;
		ValuesIn: in Bus16;
		TagsIn: in Bus16x5;
		Newest: in STD_LOGIC_VECTOR(15 downto 0);
		Value: out STD_LOGIC_VECTOR (31 downto 0);
		Tag: out STD_LOGIC_VECTOR(4 downto 0));
end ReadPort;
architecture Behavioural of ReadPort is
begin
	process(ReadAddr, DestinationsIn, ValuesIn, TagsIn)
	begin
		if ReadAddr=DestinationsIn(0) and Newest(0) then
			Value<=ValuesIn(0);
			Tag<=TAgsIn(0);
		elsif ReadAddr=DestinationsIn(1) and Newest(1) then
			Value<=ValuesIn(1);
			Tag<=TAgsIn(1);
		elsif ReadAddr=DestinationsIn(2) and Newest(2) then
			Value<=ValuesIn(2);
			Tag<=TAgsIn(2);
		elsif ReadAddr=DestinationsIn(3) and Newest(3) then
			Value<=ValuesIn(3);
			Tag<=TAgsIn(3);
		elsif ReadAddr=DestinationsIn(4) and Newest(4) then
			Value<=ValuesIn(4);
			Tag<=TAgsIn(4);
		elsif ReadAddr=DestinationsIn(5) and Newest(5) then
			Value<=ValuesIn(5);
			Tag<=TAgsIn(5);
		elsif ReadAddr=DestinationsIn(6) and Newest(6) then
			Value<=ValuesIn(6);
			Tag<=TAgsIn(6);
		elsif ReadAddr=DestinationsIn(7) and Newest(7) then
			Value<=ValuesIn(7);
			Tag<=TAgsIn(7);
		elsif ReadAddr=DestinationsIn(8) and Newest(8) then
			Value<=ValuesIn(8);
			Tag<=TAgsIn(8);
		elsif ReadAddr=DestinationsIn(9) and Newest(9) then
			Value<=ValuesIn(9);
			Tag<=TAgsIn(9);
		elsif ReadAddr=DestinationsIn(10) and Newest(10) then
			Value<=ValuesIn(10);
			Tag<=TAgsIn(10);
		elsif ReadAddr=DestinationsIn(11) and Newest(11) then
			Value<=ValuesIn(11);
			Tag<=TAgsIn(11);
		elsif ReadAddr=DestinationsIn(12) and Newest(12) then
			Value<=ValuesIn(12);
			Tag<=TAgsIn(12);
		elsif ReadAddr=DestinationsIn(13) and Newest(13) then
			Value<=ValuesIn(13);
			Tag<=TAgsIn(13);
		elsif ReadAddr=DestinationsIn(14) and Newest(14) then
			Value<=ValuesIn(14);
			Tag<=TAgsIn(14);
		elsif ReadAddr=DestinationsIn(15) and Newest(15) then
			Value<=ValuesIn(15);
			Tag<=TAgsIn(15);
		end if;
	end;
end Behavioural;