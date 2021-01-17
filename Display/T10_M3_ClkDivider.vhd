--Team 10 - 762102 872403
--Version 1.0
-- Tested on :-
-- Simulation   - No
-- Hardware     - No
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity T10_M3_ClkDivider is
    port
    (
        i_clk       : in std_logic;
        o_clk       : out std_logic
    );
end T10_M3_ClkDivider;

architecture behavioral of T10_M3_ClkDivider is
    signal r_count : unsigned(3 downto 0) := 0;
    signal r_out   : std_logic;
begin
    divide: process(i_clk)
    begin
        if (rising_edge(i_clk)) then
            r_count <= r_count + 1;
            if (r_count = 0) then
                r_out <= not r_out;
            end if;
        end if;
    end process divide;

    o_clk <= r_out;
end behavioral;
