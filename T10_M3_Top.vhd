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
    --Clocks and CEs
    signal w_CLK_100M   : std_logic;
    signal w_CLK_6M     : std_logic;
    signal w_systemClock : std_logic;
    signal w_CE1      : std_logic;
    signal w_CE2      : std_logic;
    signal w_CE16     : std_logic;
    signal w_CE250    : std_logic;

    --Inputs
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
    signal w_slow           : std_logic;

    --Display
    signal w_digit0         : std_logic_vector(3 downto 0);
    signal w_digit1         : std_logic_vector(3 downto 0);
    signal w_digit2         : std_logic_vector(3 downto 0);
    signal w_digit3         : std_logic_vector(3 downto 0);

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
end behavioral;