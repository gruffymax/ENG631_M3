-- Team 10 - 762102 872403
--Version 1

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
            if (i_Clr = '0') then
                o_Q <= i_D;
            else
                o_Q <= '0';
            end if;
        end if;
    end process flipflop;
end behavioral;