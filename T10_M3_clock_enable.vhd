--Team 10 - 762102 872403
--Version 1.0
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity T10_M2_clock_enable is
    generic
    (
        g_period_count : integer
    );

    port
    (  
        i_C100MHz       : in STD_LOGIC;
        i_Reset         : in STD_LOGIC;
        o_CE            : out STD_LOGIC
    );
end T10_M2_clock_enable;



architecture CE of T10_M2_clock_enable is
    signal r_CE_Counter : integer range 0 to g_period_count;

begin
    count: process(i_C100Mhz, i_Reset)
    begin
        if (i_Reset = '1') then --Reset counter
            r_CE_Counter <= 0;
        elsif rising_edge(i_C100MHz) then
            if (r_CE_Counter < g_period_count) then
                r_CE_Counter <= r_CE_Counter + 1; --Increment counter.
            else
                r_CE_Counter <= 0; --Rollover counter to zero.
            end if;
        end if;
    end process count;

    compare: process(i_C100MHz, i_Reset)
    begin
        if (i_Reset = '1') then --Reset CE output
            o_CE <= '0';
        elsif falling_edge(i_C100MHz) then
            if (r_CE_Counter = g_period_count) then --Compare and trigger pulse
                o_CE <= '1';
            else
                o_CE <= '0';
            end if;
        end if;
    end process compare;
end CE;