-- Team 10 762102
-- M3 Top Test Bench

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity T10_M3_Top_TB is
end T10_M3_Top_TB;

architecture behavioral of T10_M3_Top_TB is
    -- Inputs
    signal i_C100MHz    : std_logic := '0';
    signal i_Reset      : std_logic := '0';
    signal i_Start      : std_logic := '0';
    signal i_sw15       : std_logic := '0';
    signal i_sw14       : std_logic := '1';
    signal i_sw13       : std_logic := '0';
    signal i_sw12       : std_logic := '0';
    signal i_sw11       : std_logic := '0';
    signal i_sw10       : std_logic := '0';
    signal i_sw9        : std_logic := '0';
    signal i_sw8        : std_logic := '0';
    signal i_sw7        : std_logic := '0';
    signal i_sw0        : std_logic := '0';

    -- Outputs
    signal o_SegmentCathodes : std_logic_vector(6 downto 0) := "0000000";
    signal o_SegmentAnodes : std_logic_vector(3 downto 0) := "1111";
    signal o_LED_tx : std_logic_vector(1 downto 0) := "00";
    signal o_LED_rx : std_logic_vector(1 downto 0) := "00";

    -- Simulation specifics
    constant clk_period : time := 1 ns;
begin
    Top: entity work.T10_M3_Top(behavioral)
        port map
        (
            i_C100MHz   => i_C100MHz,
            i_Reset     => i_Reset,
            i_Start     => i_Start,
            i_sw15      => i_sw15,
            i_sw14      => i_sw14,
            i_sw13      => i_sw13,
            i_sw12      => i_sw12,
            i_sw11      => i_sw11,
            i_sw10      => i_sw10,
            i_sw9       => i_sw9,
            i_sw8       => i_sw8,
            i_sw7       => i_sw7,
            i_sw0       => i_sw0,
            o_SegmentCathodes   => o_SegmentCathodes,
            o_SegmentAnodes     => o_SegmentAnodes,
            o_LED_tx            => o_LED_tx,
            o_LED_rx            => o_LED_rx
        );

    clock: process
    begin
        wait for clk_period / 2;
        i_C100MHz <= not i_C100MHz;
    end process clock;

    start: process
    begin
        wait for 100 us;
        i_Start <= '1';
        wait for 3 ms;
        i_Start <= '0';
        wait;
    end process start;

end behavioral;
