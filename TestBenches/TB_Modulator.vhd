-- Team 10 - 762102 872403
--Version 1

library IEEE;
use IEEE.std_logic_1164.all;

entity TB_Modulator is
end TB_Modulator;

architecture Behavioral of TB_Modulator is
    signal i_Clk     : std_logic := '1';
    signal i_CE16     : std_logic := '0';
    signal i_symbol      : std_logic_vector(1 downto 0);
    signal i_Reset   : std_logic := '0';
    signal o_dataI      : std_logic_vector(7 downto 0);
    signal o_dataQ      : std_logic_vector(7 downto 0);
 

    --Simulation constants
    constant clk_period : time := 10 ns;


begin
    clock: process
    begin
        i_Clk <= not i_Clk;
        wait for clk_period / 2;
    end process clock;

    ce16: entity work.T10_M3_clock_enable(CE)
        generic map
        (
            g_period_count => 6250000
        )

        port map
        (
            i_C100MHz => i_Clk,
            i_Reset => i_Reset,
            o_CE => i_CE16
        );

    uut: entity work.T10_M3_Modulator(Behavioral)
        port map
        (
            i_Clk       => i_Clk,
            i_CE16      => i_CE16,
            i_symbol    => i_symbol,
            i_Reset     => i_Reset,
            o_dataI     => o_dataI,
            o_dataQ     => o_dataQ
        );

    stimulus: process
    begin
        i_Reset <= '0';
        i_symbol <= "01";
        wait for 499 ms;
        i_symbol <= "00";
        wait;
    end process;

end Behavioral;
