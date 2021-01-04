-- Team 10 - 762102 872403
--Version 1

library IEEE;
use IEEE.std_logic_1164.all;

entity TB_PRNG16 is
end TB_PRNG16;

architecture Behavioral of TB_PRNG16 is
    signal i_CE     : std_logic := '0';
    signal o_prn      : std_logic_vector(4 downto 0);
    signal i_clr    : std_logic;
 

    --Simulation constants
    constant clk_period : time := 1 ms;


begin
    uut: entity work.T10_M3_PRNG16(Behavioral)
        port map
        (
            i_CE    => i_CE,
            o_prn    => o_prn,
            i_clr   => i_clr
        );

    clock: process
    begin
        i_CE <= not i_CE; 
        wait for clk_period / 2;
    end process clock;

    start: process
    begin
        i_clr <= '1';
        wait for 2 ms;
        i_clr <= '0';
        wait;
    end process start;
end Behavioral;