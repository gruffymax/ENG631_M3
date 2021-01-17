-- Team 10 - 762102
--Version 1
-- Tested on :-
--  Simulation  - Yes
--  Hardware    - Yes

library IEEE;
use IEEE.std_logic_1164.all;

entity T10_M3_FlipFlop is
    port
    (
        i_CE    : in std_logic;
        i_D     : in std_logic;
        i_Clr  : in std_logic;
        o_Q     : out std_logic
    );
end T10_M3_FlipFlop;

architecture behavioral of T10_M3_FlipFlop is

begin
    flipflop: process(i_CE)
    begin
        if (rising_edge(i_CE)) then
            case i_Clr is
                when '1' =>
                    o_Q <= '0' after 1 ns;
                when '0' =>
                    o_Q <= i_D after 1 ns;
                when others =>
                    o_Q <= '0' after 1 ns;
            end case;
        end if;
    end process flipflop;
end behavioral;
