--Team 10 - 762102 872403
--Version 1.0
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity T10_M3_clock_enable is
    generic
    (
        g_period_count : integer
    );

    port
    (  
        i_C100MHz       : in std_logic;
        i_Reset         : in std_logic;
    	o_CE		: out std_logic
    );
end T10_M3_clock_enable;



architecture CE of T10_M3_clock_enable is
    signal r_CE_Counter : integer range 0 to g_period_count;
    signal r_CE : std_logic;

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
            r_CE <= '0' after 1 ns;
        elsif falling_edge(i_C100MHz) then
            if (r_CE_Counter = g_period_count) then --Compare and trigger pulse
                r_CE <= '1' after 1 ns;
            else
                r_CE <= '0' after 1 ns;
            end if;
        end if;
    end process compare;
    
    o_CE <= r_CE;
end CE;
