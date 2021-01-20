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
        i_sw9       : in std_logic;
        i_sw8       : in std_logic;
        i_sw7       : in std_logic;
        o_display_switch : out std_logic_vector(2 downto 0)
    );
end T10_M3_Display_Switch;

architecture behavioral of T10_M3_Display_Switch is

begin
        
    o_display_switch(2) <= i_sw9;
    o_display_switch(1) <= i_sw8;
    o_display_switch(0) <= i_sw7;
end behavioral;