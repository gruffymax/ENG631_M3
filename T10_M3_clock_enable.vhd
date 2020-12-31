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
        o_CE1           : out std_logic;
        o_CE2           : out std_logic    
    );
end T10_M3_clock_enable;



architecture CE of T10_M3_clock_enable is
    signal r_CE_Counter : integer range 0 to g_period_count;
    signal r_CE1 : std_logic;

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

    compare1: process(i_C100MHz, i_Reset)
    begin
        if (i_Reset = '1') then --Reset CE output
            r_CE1 <= '0';
        elsif falling_edge(i_C100MHz) then
            if (r_CE_Counter = g_period_count) then --Compare and trigger pulse
                r_CE1 <= '1';
            else
                r_CE1 <= '0';
            end if;
        end if;
    end process compare1;

    compare2: process(i_C100MHz)
    begin
        if (rising_edge(i_C100MHz)) then
            if (r_CE1 = '1') then
                o_CE2 <= '1';
            else
                o_CE2 <= '0';
            end if;
       end if;
    end process compare2; 
    
    o_CE1 <= r_CE1;
end CE;