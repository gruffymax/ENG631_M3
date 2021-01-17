-- Team 10 - 762102 872403
--Version 1

library IEEE;
use IEEE.std_logic_1164.all;

entity TB_Delay is
end TB_Delay;

architecture behavioral of TB_Delay is
    signal i_Clk    : std_logic := '0';
    signal i_CE     : std_logic := '0';
    signal o_CE     : std_logic := '0';
    signal i_Reset  : std_logic := '0';

    constant clock_period : time := 10 ns;
begin
    ce: entity work.T10_M3_clock_enable(CE)
        generic map
        (
            g_period_count => 40000
        )

        port map
        (
            i_C100MHz => i_Clk,
            i_Reset => i_Reset,
            o_CE => i_CE
        );
    
    delay: entity work.T10_M3_CE_Delay(behavioral)
        generic map
        (
            g_ce_delay => 6
        )
        port map
        (
            i_CE => i_CE,
            i_Clk => i_Clk,
            o_CE => o_CE
        );

    clock: process
    begin
        i_Clk <= not i_Clk;
        wait for clock_period / 2;
    end process clock;

end behavioral;