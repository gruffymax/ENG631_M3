--Team 10 - 762102 872403
-- Version 1.0
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity T10_M3_Top is
    port
    (
        i_C100MHz           : in std_logic;
        i_Reset             : in std_logic; -- Reset button
        i_Start             : in std_logic; -- Start button
        i_sw15              : in std_logic;
        i_sw14              : in std_logic;
        i_sw13              : in std_logic;
        i_sw12              : in std_logic;
        i_sw11              : in std_logic;
        i_sw10              : in std_logic;
        i_sw9               : in std_logic;
        i_sw8               : in std_logic;
        i_sw7               : in std_logic;
        i_sw0               : in std_logic;
        o_SegmentCathodes   : out std_logic_vector(6 downto 0);
        o_SegmentAnodes     : out std_logic_vector(3 downto 0);
        o_LED_tx            : out std_logic_vector(1 downto 0);
        o_LED_rx            : out std_logic_vector(1 downto 0)
    );
end T10_M3_Top;

architecture behavioral of T10_M3_Top is
    -- Clocks and CEs
    signal w_CLK_100M   : std_logic;
    signal w_CLK_6M     : std_logic;
    signal w_system_clk  : std_logic;
    signal w_CE1      : std_logic;
    signal w_CE1_delay: std_logic;
    signal w_CE2      : std_logic;
    signal w_CE2_delay: std_logic;
    signal w_CE16     : std_logic;
    signal w_CE250    : std_logic;

    -- Inputs
    signal w_sw15_db        : std_logic;
    signal w_sw14_db        : std_logic;
    signal w_sw13_db        : std_logic;
    signal w_sw12_db        : std_logic;
    signal w_sw11_db        : std_logic;
    signal w_sw10_db        : std_logic;
    signal w_sw9_db        : std_logic;
    signal w_sw8_db        : std_logic;
    signal w_sw7_db        : std_logic;
    signal w_sw0_db        : std_logic;
    signal w_start_db       : std_logic;

    -- Display wires
    signal w_digit0         : std_logic_vector(3 downto 0);
    signal w_digit1         : std_logic_vector(3 downto 0);
    signal w_digit2         : std_logic_vector(3 downto 0);
    signal w_digit3         : std_logic_vector(3 downto 0);

    -- Modulation scheme A wires 762102
    signal w_Dmod_DataA     : std_logic_vector(3 downto 0);
    signal w_IrxA   : std_logic_vector(7 downto 0);
    signal w_QrxA   : std_logic_vector(7 downto 0);
    signal w_ItxA   : std_logic_vector(7 downto 0);
    signal w_QtxA   : std_logic_vector(7 downto 0);

    -- Modulation scheme B wires 872403
    signal w_Dmod_DataB     : std_logic_vector(3 downto 0);
    signal w_IrxB   : std_logic_vector(7 downto 0);
    signal w_QrxB   : std_logic_vector(7 downto 0);
    signal w_ItxB   : std_logic_vector(7 downto 0);
    signal w_QtxB   : std_logic_vector(7 downto 0);

    -- Shared Modulation scheme wires
    signal w_mode           : std_logic_vector(3 downto 0);
    signal w_start          : std_logic;
    signal w_symbol        : std_logic_vector(1 downto 0);
    signal w_DG_Data           : std_logic_vector(3 downto 0);
    signal w_display_switch     : std_logic_vector(2 downto 0);







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
    DCM : clk_wiz_0 
        port map 
        ( 
            clk_out1 => w_CLK_100M, 
            reset => i_Reset, 
            clk_in1 => i_C100MHz
        );

    DCM_Divide: entity work.T10_M3_ClkDivider(behavioral)
        port map
        (
            i_clk => w_CLK_100M,
            o_clk => w_CLK_6M
        );

    DCM_mux: entity work.T10_M3_mux2to1(behavioral)
        port map
        (
            i_signal1 => w_CLK_100M,
            i_signal2 => w_CLK_6M,
            i_sw0 => w_sw0_db,
            o_signalOut => w_system_clk
        );

    debounce: entity work.T10_M3_Debounce_Block(behavioral)
        port map
        (
            -- Debounce to always use 100MHz clock
            i_clk => w_CLK_100M,
            i_start => i_Start,
            i_sw15 => i_sw15,
            i_sw14 => i_sw14,
            i_sw13 => i_sw13,
            i_sw12 => i_sw12,
            i_sw11 => i_sw11,
            i_sw10 => i_sw10,
            i_sw9 => i_sw9,
            i_sw8 => i_sw8,
            i_sw7 => i_sw7,
            i_sw0 => i_sw0,
            o_start => w_start_db,
            o_sw15 => w_sw15_db,
            o_sw14 => w_sw14_db,
            o_sw13 => w_sw13_db,
            o_sw12 => w_sw12_db,
            o_sw11 => w_sw11_db,
            o_sw10 => w_sw10_db,
            o_sw9 => w_sw9_db,
            o_sw8 => w_sw8_db,
            o_sw7 => w_sw7_db,
            o_sw0 => w_sw0_db
        );

    CE1  : entity work.T10_M3_clock_enable(CE)
        generic map
        (
            g_period_count => 100000000
        )
        port map
        ( 
            i_C100MHz => w_system_clk,
            i_Reset => i_Reset,
            o_CE => w_CE1
        );

    CE2  : entity work.T10_M3_clock_enable(CE)
        generic map
        (
            g_period_count => 50000000
        )
        port map
        ( 
            i_C100MHz => w_system_clk,
            i_Reset => i_Reset,
            o_CE => w_CE2
        );

    CE16  : entity work.T10_M3_clock_enable(CE)
        generic map
        (
            g_period_count => 6250000
        )
        port map
        ( 
            i_C100MHz => w_system_clk,
            i_Reset => i_Reset,
            o_CE => w_CE16
        );

    CE250  : entity work.T10_M3_clock_enable(CE)
        generic map
        (
            g_period_count => 50000
        )
        port map
        ( 
            i_C100MHz => w_system_clk,
            i_Reset => i_Reset,
            o_CE => w_CE250
        );

    startstop: entity work.T10_M3_StartStop(behavioral)
        port map
        (
            i_Clk => w_CLK_100M,
            i_Reset => i_Reset,
            i_Button => w_start_db,
            o_StartStop => w_start
        );

    
    SelectSwitchDecode: entity work.T10_M3_DG_SelectSwitchDecoder(behavioral)
        port map
        (
            i_Clk => w_CLK_100M,
            i_sw15 => w_sw15_db,
            i_sw14 => w_sw14_db,
            i_sw13 => w_sw13_db,
            i_sw12 => w_sw12_db,
            o_mode => w_mode
        );

    dataGen: entity work.T10_M3_DataGenerator(behavioral)
        port map
        (
            i_Clk => w_system_clk,
            i_Reset => i_Reset,
            i_CE1 => w_CE1,
            i_mode => w_mode,
            i_start => w_start,
            o_data => w_DG_Data
        );

    dg_delay1: entity work.T10_M3_CE_Delay(behavioral)
        generic map
        (
            g_ce_delay => 2
        )
        port map
        (
            i_CE => w_CE1,
            i_Clk => w_system_clk,
            o_CE => w_CE1_delay
        );

    dg_delay2: entity work.T10_M3_CE_Delay(behavioral)
        generic map
        (
            g_ce_delay => 2
        )
        port map
        (
            i_CE => w_CE2,
            i_Clk => w_system_clk,
            o_CE => w_CE2_delay
        );

    symbolConv: entity work.T10_M3_symbolConvert(archSymbolConvert)
        port map
        (
            i_sysClock => w_system_clk,
            i_data => w_DG_Data,
            i_CE1Hz => w_CE1_delay,
            i_CE2Hz => w_CE2_delay,
            o_LED_tx => o_LED_tx,
            i_Reset => i_Reset,
            o_symbol => w_symbol
        );

    Display: entity work.T10_M3_displayDriver(archDisplayDriver)
        port map
        (
            i_sysClock => w_system_clk,       
            i_Reset => i_Reset,        
            i_CE250Hz => w_CE250,       
            i_BCDInput0 => w_digit0,  
            i_BCDInput1 => w_digit1,
            i_BCDInput2 => w_digit2,
            i_BCDInput3 => w_digit3,       
            o_SegmentCathode => o_SegmentCathodes,
            o_SegmentAnode => o_SegmentAnodes
        );

    DisplaySwitch: entity work.T10_M3_Display_Switch(behavioral)
        port map
        (
            i_clk => w_CLK_100M,
            i_sw9 => w_sw9_db,
            i_sw8 => w_sw8_db,
            i_sw7 => w_sw7_db,
            o_display_switch => w_display_switch
        );

    DisplayMux: entity work.T10_M3_Display_Mplx(behavioral)
        port map
        (
            i_clk => w_system_clk,
            i_select => w_display_switch,
            i_DG_Mode => w_mode,
            i_DG_Data => w_DG_Data,
            i_Dmod_DataA => w_Dmod_DataA,
            i_Dmod_DataB => w_Dmod_DataB,
            i_SC_Symbol => w_symbol,
            i_ItxA => w_ItxA,
            i_QtxA => w_QtxA,
            i_ItxB => w_ItxB,
            i_QtxB => w_QtxB,
            i_IrxA => w_IrxA,
            i_QrxA => w_QrxA,
            i_IrxB => w_IrxB,
            i_QrxB => w_QrxB,
            o_D3 => w_digit3,
            o_D2 => w_digit2,
            o_D1 => w_digit1,
            o_D0 => w_digit0
        );

    -- 762102
    ModA: entity work.T10_M3_ModA(behavioral)
        port map
        (
            i_clk       => w_system_clk,
            i_CE16      => w_CE16,
            i_symbol    => w_symbol,
            i_Reset     => i_Reset,
            i_sw10      => w_sw10_db,
            i_sw11      => w_sw11_db,
            o_data      => w_Dmod_DataA,
            o_Itx       => w_ItxA,
            o_Qtx       => w_QtxA,
            o_Irx       => w_IrxA,
            o_Qrx       => w_QrxA,
            o_LED_rx    => o_LED_rx
        );

    -- 872403
    ModB: entity work.T10_M3_modem(archModem)
        port map
        (
            i_sysClock  => w_system_clk,
            i_CE2Hz     => w_CE2,
            i_CE250Hz   => w_CE250,
            i_Symbol    => w_symbol,
            o_I_Tx      => w_ItxB,
            o_Q_Tx      => w_QtxB,
            o_dat_Rx    => w_Dmod_DataB,
            o_I_Rx      => w_IrxB,
            o_Q_Rx      => w_QrxB
        );
end behavioral;