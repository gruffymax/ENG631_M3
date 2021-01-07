--Team 10 - 762102 872403
-- Version 1.0
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity T10_M2_top is
    port
    (
        i_C100MHz           : in STD_LOGIC;
        i_Reset             : in STD_LOGIC;
        i_sw15              : in std_logic;
        i_sw14              : in std_logic;
        i_sw13              : in std_logic;
        i_sw12              : in std_logic;
        i_start             : in std_logic;
        o_SegmentCathodes   : out STD_LOGIC_VECTOR(6 downto 0);
        o_SegmentAnodes     : out STD_LOGIC_VECTOR(3 downto 0);
        o_led               : out STD_LOGIC_VECTOR(1 downto 0)
    );
end T10_M2_top;

architecture Behavioral of T10_M2_top is
    --Clocks and CEs
    signal w_systemClock    : STD_LOGIC;
    signal w_1Hz_ce      : STD_LOGIC;
    signal w_2Hz_ce      : STD_LOGIC;
    signal w_250Hz_ce    : STD_LOGIC;
    --Display
    signal w_digit0         : STD_LOGIC_VECTOR(3 downto 0);
    signal w_digit1         : STD_LOGIC_VECTOR(3 downto 0);
    --Debounced inputs
    signal w_sw15_db        : std_logic;
    signal w_sw14_db        : std_logic;
    signal w_sw13_db        : std_logic;
    signal w_sw12_db        : std_logic;
    signal w_start_db       : std_logic;
    --Other connections
    signal w_data_mp        : std_logic_vector(3 downto 0);
    signal w_mode           : std_logic_vector(3 downto 0);
    signal w_start          : std_logic;
    signal w_data_sc        : std_logic_vector(3 downto 0);
    signal w_data           : std_logic_vector(3 downto 0);


    -- DCM generated component declaration, copied from stub VHDL file
    component clk_wiz_0 is
        Port 
        (
            clk_out1 : out STD_LOGIC;
            reset : in STD_LOGIC;
            locked : out STD_LOGIC;
            clk_in1 : in STD_LOGIC
        );
    end component;
begin
    -- instantiate DCM block
    DCM : clk_wiz_0 
        port map 
        ( 
            clk_out1 => w_SystemClock, 
            reset => i_Reset, 
            clk_in1 => i_C100MHz
        );
    CE2Hz: entity work.T10_M2_clock_enable(CE)
        generic map
        (
            g_period_count => 50000000
        )
        port map
        (
            i_C100MHz => w_systemClock,
            i_Reset => i_Reset,
            o_CE => w_2Hz_ce
        );
    
    CE1Hz  : entity work.T10_M2_clock_enable(CE)
        generic map
        (
            g_period_count => 100000000
        )
        port map
        ( 
            i_C100MHz => w_systemClock,
            i_Reset => i_Reset,
            o_CE => w_1Hz_ce
        );
    
    CE250Hz : entity work.T10_M2_clock_enable(CE)
        generic map
        (
            g_period_count => 400000
        )
        port map
        (
            i_C100MHz => w_systemClock,
            i_Reset => i_Reset,
            o_CE => w_250Hz_ce
        );
    
    Display: entity work.T10_M2_displayDriver(archDisplayDriver)
        port map
        (
            i_sysClock => w_systemClock,       
            i_Reset => i_Reset,        
            i_CE250Hz => w_250Hz_ce,       
            i_BCDInput0 => w_digit0,  
            i_BCDInput1 => w_digit1,
            i_BCDInput2 => w_data,
            i_BCDInput3 => w_mode,       
            o_SegmentCathode => o_SegmentCathodes,
            o_SegmentAnode => o_SegmentAnodes
        );

    startstop: entity work.T10_M2_StartStop(behavioral)
        port map
        (
            i_Clk => w_systemClock,
            i_Reset => i_Reset,
            i_Button => w_start_db,
            o_StartStop => w_start
        );

    SelectSwitchDecode: entity work.T10_M2_DG_SelectSwitchDecoder(behavioral)
        port map
        (
            i_Clk => w_systemClock,
            i_sw15 => w_sw15_db,
            i_sw14 => w_sw14_db,
            i_sw13 => w_sw13_db,
            i_sw12 => w_sw12_db,
            o_mode => w_mode
        );

    symbolConv: entity work.T10_M2_symbolConvert(archSymbolConvert)
        port map
        (
            i_sysClock => w_systemClock,
            i_data => w_data,
            i_CE1Hz => w_1Hz_ce,
            i_CE2Hz => w_2Hz_ce,
            o_led => o_led,
            o_BCDOut0 => w_digit0,
            o_BCDOut1 => w_digit1
        );
    
    dataGen: entity work.T10_M2_DataGenerator(behavioral)
        port map
        (
            i_Clk => w_systemClock,
            i_Reset => i_Reset,
            i_CE1 => w_1Hz_ce,
            i_mode => w_mode,
            i_start => w_start,
            o_data => w_data
        );

    debounce15: entity work.T10_M2_Debounce(behavioral)
        port map
        (
            i_input => i_sw15,
            i_Clk => w_systemClock,
            o_output => w_sw15_db
        );
    
    debounce14: entity work.T10_M2_Debounce(behavioral)
        port map
        (
            i_input => i_sw14,
            i_Clk => w_systemClock,
            o_output => w_sw14_db
        );

    debounce13: entity work.T10_M2_Debounce(behavioral)
        port map
        (
            i_input => i_sw13,
            i_Clk => w_systemClock,
            o_output => w_sw13_db
        );

    debounce12: entity work.T10_M2_Debounce(behavioral)
        port map
        (
            i_input => i_sw12,
            i_Clk => w_systemClock,
            o_output => w_sw12_db
        );

    debounceStart: entity work.T10_M2_Debounce(behavioral)
        port map
        (
            i_input => i_start,
            i_Clk => w_systemClock,
            o_output => w_start_db
        );
end Behavioral;
