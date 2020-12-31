--Team 10 - 762102 872403

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TB_clock250hz is
end TB_clock250hz;

architecture Behavioral of TB_clock250hz is
    --Inputs
    signal i_C100MHz : STD_LOGIC := '0';
    signal i_Reset   : STD_LOGIC := '0';
    
    --Outputs
    signal o_CE1      : STD_LOGIC := '0';
    signal o_CE2      : std_logic := '0';

    --Simulation specifics
    constant C100MHz_Period : time := 10 ns;

begin
    uut: entity work.T10_M3_clock_enable(CE)
        generic map
        (
            g_period_count => 400000 --Set generic for a 250 Hz freq.  
        )
        port map
        (
            i_C100MHz => i_C100MHz,
            i_Reset => i_Reset,
            o_CE1 => o_CE1,
            o_CE2 => o_CE2
        );

    --Clock Process Definition
    sysClock_process :process
    begin
        i_C100MHz <= '0';
        wait for C100MHz_Period/2;
        i_C100MHz <= '1';
        wait for C100MHz_Period/2;
    end process;


end Behavioral;
