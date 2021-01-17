-- Team 10 - 762102 872403
--Version 1
-- Tested on :-
--  Simulation  - No
--  Hardware    - No

library IEEE;
use IEEE.std_logic_1164.all;

entity T10_M3_Display_Switch is
    port
    (
        i_clk       : in std_logic;
        i_sw9       : in std_logic;
        i_sw8       : in std_logic;
        i_sw7       : in std_logic;
        o_display_switch : out std_logic_vector(2 downto 0)
    );
end T10_M3_Display_Switch;

architecture behavioral of T10_M3_Display_Switch is
    signal w_sw9    : std_logic := '0';
    signal w_sw8    : std_logic := '0';
    signal w_sw7    : std_logic := '0';
begin
    db9: entity work.T10_M3_Debounce(behavioral)
        port map
        (
            i_Clk => i_clk,
            i_input => i_sw9,
            o_output => w_sw9
        );
    
    db8: entity work.T10_M3_Debounce(behavioral)
        port map
        (
            i_Clk => i_clk,
            i_input => i_sw8,
            o_output => w_sw8
        );

    db7: entity work.T10_M3_Debounce(behavioral)
        port map
        (
            i_Clk => i_clk,
            i_input => i_sw7,
            o_output => w_sw7
        );
        
    o_display_switch(2) <= w_sw9;
    o_display_switch(1) <= w_sw8;
    o_display_switch(0) <= w_sw7;
end behavioral;