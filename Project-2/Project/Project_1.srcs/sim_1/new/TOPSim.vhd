library ieee;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;

entity TOPSim is
end TOPSim;

architecture tb of TOPSim is

    component TOP
        port (IssueIn           : in std_logic;
              FUType            : in std_logic_vector (1 downto 0);
              Fop               : in std_logic_vector (1 downto 0);
              Ri                : in std_logic_vector (4 downto 0);
              Rj                : in std_logic_vector (4 downto 0);
              Rk                : in std_logic_vector (4 downto 0);
              BufferAvailable   : in std_logic_vector (2 downto 0);
              CDB_QBuffer       : in std_logic_vector (4 downto 0);
              CDB_VBuffer       : in std_logic_vector (31 downto 0);
              CDB_BufferRequest : in std_logic;
              Accepted          : out std_logic;
              Clk               : in std_logic;
              Rst               : in std_logic);
    end component;

    signal IssueIn           : std_logic;
    signal FUType            : std_logic_vector (1 downto 0);
    signal Fop               : std_logic_vector (1 downto 0);
    signal Ri                : std_logic_vector (4 downto 0);
    signal Rj                : std_logic_vector (4 downto 0);
    signal Rk                : std_logic_vector (4 downto 0);
    signal BufferAvailable   : std_logic_vector (2 downto 0);
    signal CDB_QBuffer       : std_logic_vector (4 downto 0);
    signal CDB_VBuffer       : std_logic_vector (31 downto 0);
    signal CDB_BufferRequest : std_logic;
    signal Accepted          : std_logic;
    signal Clk               : std_logic;
    signal Rst               : std_logic;

    constant TbPeriod : time := 10 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : TOP
    port map (IssueIn           => IssueIn,
              FUType            => FUType,
              Fop               => Fop,
              Ri                => Ri,
              Rj                => Rj,
              Rk                => Rk,
              BufferAvailable   => BufferAvailable,
              CDB_QBuffer       => CDB_QBuffer,
              CDB_VBuffer       => CDB_VBuffer,
              CDB_BufferRequest => CDB_BufferRequest,
              Accepted          => Accepted,
              Clk               => Clk,
              Rst               => Rst);

    -- Clock generation
    -- TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';
    clk_process :process
    begin
        TbClock <= '1';
        wait for TbPeriod/2;
        TbClock <= '0';
        wait for TbPeriod/2;
    end process;
    
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
        BufferAvailable <= (others => '0');
        CDB_QBuffer <= (others => '0');
        CDB_VBuffer <= (others => '0');
        CDB_BufferRequest <= '0';

        -- Reset generation
        -- EDIT: Check that Rst is really your reset signal
        Rst <= '1';
        wait for 100 ns;
        Rst <= '0';
--        wait for 100 ns;

        -- Injecting Data On Registers Through Simulated Buffer --------------------
        
        -- 7 on register 1 ---------------------------------------------------------
        -- Set Buffer Tag
        IssueIn <= '1'; -- Issue
        FUType <= "10"; -- Load Buffer
        Ri <= "00001"; -- Destination Register
        BufferAvailable <= "001"; --Simulated buffer id
        wait for TbPeriod;

        -- Stop Issue
        IssueIn <= '0';
        wait for TbPeriod;

        -- Request CDB
        CDB_BufferRequest <= '1';

        -- Load Data to RF through cdb
        CDB_QBuffer <= "10001";
        CDB_VBuffer <= std_logic_vector(to_unsigned(7,32));
        wait for TbPeriod;
        CDB_BufferRequest <= '0';

        -- 2 on register 2 ---------------------------------------------------------
        -- Set Buffer Tag
        IssueIn <= '1'; -- Issue
        FUType <= "10"; -- Load Buffer
        Ri <= "00010"; -- Destination Register
        BufferAvailable <= "001"; --Simulated buffer id
        wait for TbPeriod;

        -- Stop Issue
        IssueIn <= '0';
        wait for TbPeriod;

        -- Request CDB
        CDB_BufferRequest <= '1';

        -- Load Data to RF through cdb
        CDB_QBuffer <= "10001";
        CDB_VBuffer <= std_logic_vector(to_unsigned(2,32));
        wait for TbPeriod;
        CDB_BufferRequest <= '0';
        wait for TbPeriod;
        
        -- Dont Mind Me.. Im just setting things straight.
        IssueIn <= '0'; 			-- Issue
        BufferAvailable <= (others => '0');
        CDB_QBuffer <= (others => '0');
        CDB_VBuffer <= (others => '0');
        CDB_BufferRequest <= '0';
        wait for TbPeriod*3;
        
        -- 2 + 7 = 9  on register 3-------------------------------------------------
        IssueIn <= '1'; 			-- Issue
        FUType <= "01"; 			-- Arithmetical Unit 
        Fop <= "00";                -- Operation 00 = Add
        Ri <= "00011"; 				-- Destination Register 3
        Rj <= "00010";              -- Source 2
        Rk <= "00001";              -- Source 1
        wait for TbPeriod;

        -- 2 - 9 = -7  on register 4 ----------------------------------------------
        IssueIn <= '1'; 			-- Issue
        FUType <= "01"; 			-- Arithmetical Unit 
        Fop <= "01";                -- Operation 01 = Sub
        Ri <= "00100"; 				-- Destination Register 4
        Rj <= "00010";              -- Source 2
        Rk <= "00011";              -- Source 3
        wait for TbPeriod*1;
        
		-- 2 << 1 = 4  on register 5 ----------------------------------------------
		IssueIn <= '1'; 			-- Issue
		FUType <= "01";     		-- Arithmetical Unit 
		Fop <= "10";                -- Operation 10 = Shift Left
		Ri <= "00101"; 				-- Destination Register 5
		Rj <= "00010";              -- Source 2
		Rk <= "00011";              -- Source 3
		wait for TbPeriod*1;
		
        -- 2 OR 9 = 11  on register 6 ----------------------------------------------
        IssueIn <= '1'; 			-- Issue
        FUType <= "00"; 			-- Logical Unit 
        Fop <= "00";                -- Operation 00 = OR
        Ri <= "00110"; 				-- Destination Register 6
        Rj <= "00010";              -- Source 2
        Rk <= "00011";              -- Source 3
        wait for TbPeriod*1;
                
        -- 7 AND 9 = 1  on register 7 ----------------------------------------------
        IssueIn <= '1'; 			-- Issue
        FUType <= "00";             -- Logical Unit 
        Fop <= "01";                -- Operation 01 = AND
        Ri <= "00111";              -- Destination Register 7
        Rj <= "00001";              -- Source 1
        Rk <= "00011";              -- Source 3
        wait for TbPeriod*1;
               
        -- NOT 2 = 4294967293(Unsigned) -3(Signed)  on register 8 ------------------
        IssueIn <= '1'; 			-- Issue
        FUType <= "00";             -- Logical Unit 
        Fop <= "10";                -- Operation 10 = NOT
        Ri <= "01000";              -- Destination Register 8
        Rj <= "00010";              -- Source 2
        Rk <= "00011";              -- Source 3
        wait for TbPeriod*3;

        IssueIn <= '0';             -- Issue
        wait for TbPeriod*3;

        -- 2 + 0 = 2  on register 9-------------------------------------------------
        IssueIn <= '1';             -- Issue
        FUType <= "01";             -- Arithmetical Unit 
        Fop <= "00";                -- Operation 00 = Add
        Ri <= "01001";              -- Destination Register 9
        Rj <= "00010";              -- Source 2
        Rk <= "00000";              -- Source 0
        wait for TbPeriod *1;

        -- 2 + 0 = 2  on register 10------------------------------------------------
        IssueIn <= '1';             -- Issue
        FUType <= "01";             -- Arithmetical Unit 
        Fop <= "00";                -- Operation 00 = Add
        Ri <= "01010";              -- Destination Register 10
        Rj <= "00010";              -- Source 2
        Rk <= "00000";              -- Source 0
        wait for TbPeriod *1;

        -- 2 + 2 = 4  on register 9-------------------------------------------------
        IssueIn <= '1';             -- Issue
        FUType <= "01";             -- Arithmetical Unit 
        Fop <= "00";                -- Operation 00 = Add
        Ri <= "01001";              -- Destination Register 9
        Rj <= "01001";              -- Source 9
        Rk <= "01010";              -- Source 10
        wait for TbPeriod *1;

        -- 4 + 2 = 6  on register 10------------------------------------------------
        IssueIn <= '1';             -- Issue
        FUType <= "01";             -- Arithmetical Unit 
        Fop <= "00";                -- Operation 00 = Add
        Ri <= "01010";              -- Destination Register 10
        Rj <= "01001";              -- Source 9
        Rk <= "01010";              -- Source 10
        wait for TbPeriod *3;



        IssueIn <= '0';
        wait;
    end process;
end tb;