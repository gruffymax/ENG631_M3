-- Team 10 - 762102 872403
--Version 1

library IEEE;
use IEEE.std_logic_1164.all;

entity TB_Divider is
end TB_Divider;

architecture Behavioral of TB_Divider is
    signal i_clk    : std_logic;
    signal o_clk    : std_logic;
 

    --Simulation constants
    constant clk_period : time := 10 ns;


begin
    uut: entity work.T10_M3_ClkDivider(Behavioral)
        port map
        (
            i_clk => i_clk,
            o_clk => o_clk
        );

    clock: process
    begin
        i_CE <= '0';
        wait for clk_period;
        i_CE <= '1';
        wait for clk_period;
    end process;

end Behavioral;