-- Team 10 762102
-- Version 0
-- Tested on :-
--  Simulation - No
--  Hardware   - No

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity T10_M3_CE_Delay is
    generic
    (
        g_ce_delay : integer
    );

    port
    (
        i_CE    : in std_logic;
        i_Clk   : in std_logic;
        o_CE    : out std_logic
    );
end T10_M3_CE_Delay;

architecture behavioral of T10_M3_CE_Delay is
    signal r_start : std_logic := '0';
    signal r_run : std_logic := '0';
    signal r_count : integer range 0 to 15 := 0;

begin
    start: process(i_Clk)
    begin
        if (rising_edge(i_Clk)) then
            if (i_CE = '1') then
                r_start <= '1';
            else
                r_start <= '0';
            end if;
        end if;
    end process start;

    count: process(i_Clk)
    begin
        if (falling_edge(i_Clk)) then
            o_CE <= '0';
            if (r_start = '1') then
                r_run <= '1';
            end if;
            if (r_run = '1') then  
                if (r_count < g_ce_delay) then
                    r_count <= r_count + 1;
                else
                    r_count <= 0;
                    o_CE <= '1';
                    r_run <= '0';
                end if;
            end if;
        end if;
    end process count;

end behavioral;
