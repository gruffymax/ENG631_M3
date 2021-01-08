-- Team 10 - 762102 872403
--Version 1

library IEEE;
use IEEE.std_logic_1164.all;

entity TB_PRNG256 is
end TB_PRNG256;

architecture Behavioral of TB_PRNG256 is
    signal i_CE     : std_logic := '0';
    signal o_prn      : std_logic_vector(7 downto 0);

    --Simulation constants
    constant clk_period : time := 1 ms;

begin
    uut: entity work.T10_M3_PRNG256(Behavioral)
        port map
        (
            i_CE    => i_CE,
            i_clr => w_clr,
            o_prn    => o_prn
        );

    clock: process
    begin
        i_CE <= not i_CE; 
        wait for clk_period / 2;
    end process clock;
end Behavioral;