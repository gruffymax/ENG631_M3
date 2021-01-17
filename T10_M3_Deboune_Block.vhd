--Team 10 - 762102 872403
--Version 1.0
-- Tested on :-
-- Simulation   - No
-- Hardware     - No
library IEEE;
use IEEE.std_logic_1164.all;

entity T10_M3_Debounce_Block is
    port
    (
        i_clk  : in std_logic;
        i_start: in std_logic;
        i_sw15 : in std_logic;
        i_sw14 : in std_logic;
        i_sw13 : in std_logic;
        i_sw12 : in std_logic;
        i_sw11 : in std_logic;
        i_sw10 : in std_logic;
        i_sw9 : in std_logic;
        i_sw8 : in std_logic;
        i_sw7 : in std_logic;
        i_sw0 : in std_logic;
        o_start: out std_logic;
        o_sw15 : out std_logic;
        o_sw14 : out std_logic;
        o_sw13 : out std_logic;
        o_sw12 : out std_logic;
        o_sw11 : out std_logic;
        o_sw10 : out std_logic;
        o_sw9 : out std_logic;
        o_sw8 : out std_logic;
        o_sw7 : out std_logic;
        o_sw0 : out std_logic

    );
end T10_M3_Debounce_Block;

architecture behavioral of T10_M3_Debounce_Block is

begin
    debounceStart: entity work.T10_M3_Debounce(behavioral)
        port map
        (
            i_input => i_start,
            i_Clk => i_clk,
            o_output => o_start
        );
    debounce15: entity work.T10_M3_Debounce(behavioral)
        port map
        (
            i_input => i_sw15,
            i_Clk => i_clk,
            o_output => o_sw15
        );
    
    debounce14: entity work.T10_M3_Debounce(behavioral)
        port map
        (
            i_input => i_sw14,
            i_Clk => i_clk,
            o_output => o_sw14
        );

    debounce13: entity work.T10_M3_Debounce(behavioral)
        port map
        (
            i_input => i_sw13,
            i_Clk => i_clk,
            o_output => o_sw13
        );

    debounce12: entity work.T10_M3_Debounce(behavioral)
        port map
        (
            i_input => i_sw12,
            i_Clk => i_clk,
            o_output => o_sw12
        );
    
    debounce10: entity work.T10_M3_Debounce(behavioral)
        port map
        (
            i_input => i_sw10,
            i_Clk => i_clk,
            o_output => o_sw10
        );
    
    debounce9: entity work.T10_M3_Debounce(behavioral)
        port map
        (
            i_input => i_sw9,
            i_Clk => i_clk,
            o_output => o_sw9
        );

    debounce8: entity work.T10_M3_Debounce(behavioral)
        port map
        (
            i_input => i_sw8,
            i_Clk => i_clk,
            o_output => o_sw8
        );

    debounce7: entity work.T10_M3_Debounce(behavioral)
        port map
        (
            i_input => i_sw7,
            i_Clk => i_clk,
            o_output => o_sw7
        );

    debounce0: entity work.T10_M3_Debounce(behavioral)
        port map
        (
            i_input => i_sw0,
            i_Clk => i_clk,
            o_output => o_sw0
        );
end behavioral;