--Team 10 - 762102 872403
-- Version 1.0
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity TB_DG is
end TB_DG;

architecture Behavioral of TB_DG is
    signal i_Clk  : std_logic := '0';
    signal i_Reset : std_logic := '0';
    signal i_CE1  : std_logic := '0';
    signal i_start  : std_logic := '1';
    signal i_mode : std_logic_vector(3 downto 0) := "0100";
    signal o_data : std_logic_vector(3 downto 0) := "0000";

begin
    CE1Hz  : entity work.T10_M3_clock_enable(CE)
        generic map
        (
            g_period_count => 10000
        )
        port map
        ( 
            i_C100MHz => i_clk,
            i_Reset => i_Reset,
            o_CE => i_CE1
        );
    
    dataGen: entity work.T10_M3_DataGenerator(behavioral)
        port map
        (
            i_Clk => i_Clk,
            i_Reset => i_Reset,
            i_CE1 => i_CE1,
            i_mode => i_mode,
            i_start => i_start,
            o_data => o_data
        );

    clock: process
    begin
        wait for 10 ns;
        i_Clk <= not i_Clk;
    end process clock;
end Behavioral;
