-- Team 10 - 762102 872403
-- Version 1.0

library IEEE;
use IEEE.std_logic_1164.all;

entity T10_M3_StartStop is
    port
    (        
        i_Clk       : in std_logic;
        i_Reset     : in std_logic;
        i_Button    : in std_logic;
        o_StartStop : out std_logic
    );
end T10_M3_StartStop;

architecture behavioral of T10_M3_StartStop is
    signal r_prev   : std_logic := '0';
    signal r_start  : std_logic := '0';

begin
    startstop: process(i_Clk, i_Reset)
    begin
        if (i_Reset = '1') then
            r_start <= '0';
        elsif (rising_edge(i_Clk)) then
            if (r_prev /= i_Button) then
                if (i_Button = '1') then
                    r_start <= not r_start;
                end if;
            end if;
            r_prev <= i_Button;
        end if;
    end process startstop;

    o_StartStop <= r_start;
end behavioral;
