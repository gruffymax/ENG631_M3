-- Team 10 - 762102 872403
--Version 1

library IEEE;
use IEEE.std_logic_1164.all;

entity TB_Channel is
end TB_Channel;

architecture behavioral of TB_Channel is
    --Inputs
    signal i_clk       : std_logic := '0';
    signal i_prn       : std_logic_vector(7 downto 0);
    signal i_mode_sw0  : std_logic := '1';
    signal i_mode_sw1  : std_logic := '0';
    --Outputs
    signal o_Irx       : std_logic_vector(7 downto 0);
    signal o_Qrx       : std_logic_vector(7 downto 0);
    --Simulation specifics
    constant clk_period : time := 10 ns;
    signal w_symbol     : std_logic_vector(1 downto 0) := "01";
    signal w_reset      : std_logic := '0';
    signal w_Itx        : std_logic_vector(7 downto 0);
    signal w_Qtx        : std_logic_vector(7 downto 0);
    signal w_CE         : std_logic;
    signal w_CE_delay   : std_logic;


begin
    clock: process
    begin
        i_clk <= not i_clk;
        wait for clk_period / 2;
    end process clock;

    channel: entity work.T10_M3_Channel(behavioral)
        port map
        (
            i_clk       => i_clk,
            i_CE        => w_CE_delay,
            i_Itx       => w_Itx,
            i_Qtx       => w_Qtx,
            i_prn       => i_prn,
            i_sw10  => i_mode_sw0,
            i_sw11  => i_mode_sw1,
            o_Irx       => o_Irx,
            o_Qrx       => o_Qrx
        );

    modulator: entity work.T10_M3_Modulator(behavioral)
        port map
        (
            i_Clk       => i_clk,
            i_CE16      => w_CE,
            i_symbol    => w_symbol,
            i_Reset     => w_reset,
            o_dataI     => w_Itx,
            o_dataQ     => w_Qtx
        );

    ce16: entity work.T10_M3_clock_enable(CE)
        generic map
        (
            g_period_count => 6250000
        )

        port map
        (
            i_C100MHz => i_clk,
            i_Reset => w_reset,
            o_CE => w_CE   
        );

    delay: entity work.T10_M3_CE_Delay(behavioral)
        generic map
        (
            g_ce_delay => 2
        )
        port map
        (
            i_CE => w_CE,
            i_Clk => i_clk,
            o_CE => w_CE_delay
        );

    random: entity work.T10_M3_PRNG256(behavioral)
        port map
        (
            i_CE => w_CE,
            o_prn => i_Prn
        );

end behavioral;