-- Team 10 - 762102 872403
--Version 1

library IEEE;
use IEEE.std_logic_1164.all;

entity TB_CRC is
end TB_CRC;

architecture Behavioral of TB_CRC is
    signal i_CE     : std_logic := '0';
    signal i_data      : std_logic := '1';
    signal i_Clr   : std_logic := '0';
    signal o_crc      : std_logic_vector(2 downto 0);
 

    --Simulation constants
    constant clk_period : time := 1 ms;


begin
    uut: entity work.T10_M3_CRC_LFSR(Behavioral)
        port map
        (
            i_CE    => i_CE,
            i_data     => i_data,
            i_Clr  => i_Clr,
            o_crc     => o_crc
        );

    stimulus: process
    begin
        i_Clr <= '1';
        wait for 100 ns;
        i_CE <= '1';
        wait for 100 ns;
        i_CE <= '0';
        i_Clr <= '0';
        
        wait for 50 ns;
        i_data <= '1'; --Data
        --wait for 50 ns;
        i_CE <= '1';
        wait for 100 ns;
        i_CE <= '0';

        wait for 50 ns;
        i_data <= '1'; --Data
        --wait for 50 ns;
        i_CE <= '1';
        wait for 100 ns;
        i_CE <= '0';
        
        wait for 50 ns;
        i_data <= '1'; --Data
        --wait for 50 ns;
        i_CE <= '1';
        wait for 100 ns;
        i_CE <= '0';

        wait for 50 ns;
        i_data <= '0'; --Data
        --wait for 50 ns;
        i_CE <= '1';
        wait for 100 ns;
        i_CE <= '0';
        wait;
    end process;

end Behavioral;