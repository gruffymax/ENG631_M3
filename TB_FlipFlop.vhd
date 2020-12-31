-- Team 10 - 762102 872403
--Version 1

library IEEE;
use IEEE.std_logic_1164.all;

entity TB_FlipFlop is
end TB_FlipFlop;

architecture Behavioral of TB_FlipFlop is
    signal i_CE     : std_logic := '0';
    signal i_D      : std_logic := '1';
    signal i_Clr   : std_logic := '0';
    signal o_Q      : std_logic := '0';
 

    --Simulation constants
    constant clk_period : time := 1 ms;


begin
    uut: entity work.T10_M3_FlipFlop(Behavioral)
        port map
        (
            i_CE    => i_CE,
            i_D     => i_D,
            i_Clr  => i_Clr,
            o_Q     => o_Q
        );

    clock: process
    begin
        i_CE <= '0';
        wait for clk_period;
        i_CE <= '1';
        wait for clk_period;
    end process;

    stimulus: process
    begin
        wait for 500 us;
        i_D <= '0';
        wait for 2 ms;
        i_D <= '1';
        wait for 2 ms;
        i_D <= '0';
        wait for 2 ms;
        i_Clr <= '1';
        i_D <= '1';
        wait;
    end process;

end Behavioral;