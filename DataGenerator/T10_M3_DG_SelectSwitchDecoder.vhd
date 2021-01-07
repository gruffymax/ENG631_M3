-- Team 10 - 762102 872403
-- Version 1.0
-- Tested on :-
--  Simulation  - Yes
--  Hardware    - Yes

library IEEE;
use IEEE.std_logic_1164.all;

entity T10_M3_DG_SelectSwitchDecoder is
    port
    (
        i_Clk  : in std_logic;
        i_sw15 : in std_logic;
        i_sw14 : in std_logic;
        i_sw13 : in std_logic;
        i_sw12 : in std_logic;
        o_mode : out std_logic_vector(3 downto 0)
    );
end T10_M3_DG_SelectSwitchDecoder;

architecture behavioral of T10_M3_DG_SelectSwitchDecoder is
    signal r_mode : std_logic_vector(3 downto 0);
begin
    mode: process(i_Clk)
    begin
        if (rising_edge(i_Clk)) then 
            if (i_sw15 = '1') then
                r_mode <= "1000";
            else
                r_mode(3) <= '0';
                r_mode(2) <= i_sw14;
                r_mode(1) <= i_sw13;
                r_mode(0) <= i_sw12;
            end if;
        end if;
    end process mode;

    o_mode <= r_mode;
end behavioral;
