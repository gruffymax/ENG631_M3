-- Team 10 762102
-- Version 0
-- Tested on :-
--  Simulation - No
--  Hardware   - No

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity T10_M3_CE_Delay is
    port
    (
        i_CE    : in std_logic;
        i_Clk   : in std_logic;
        o_CE    : out std_logic
    );
end T10_M3_CE_Delay;

architecture behavioral of T10_M3_CE_Delay is
    signal r_trigger : std_logic := '0';
    signal r_count   : unsigned(1 downto 0) := "00";
begin
    delay: process(i_Clk)
    begin
        if (rising_edge(i_Clk)) then
            if (i_CE = '1') then
                r_trigger <= '1';
            end if;

            if (r_trigger = '1') then
                r_count <= r_count + 1;
            end if;
        end if;
    end process delay;

    trigger: process(i_Clk)
    begin
        if (falling_edge(i_Clk)) then
            if (r_count = "11") then
                o_CE <= '1';
            else
                o_CE <= '0';
            end if;
        end if;
    end process trigger;
    
end behavioral;
