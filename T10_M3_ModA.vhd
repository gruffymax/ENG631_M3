--Team 10 - 762102
--Version 1
-- Tested on :-
-- Simulation   - Yes
-- Hardware     - Yes

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity T10_M3_ModA is
    port
    (
        i_clk   : in std_logic;
        i_CE16  : in std_logic;
        i_symbol: in std_logic_vector(1 downto 0);
        i_Reset : in std_logic;
        i_error_switch  : in std_logic_vector(1 downto 0);
        o_data  : out std_logic_vector(3 downto 0);
        o_Itx   : out std_logic_vector(7 downto 0);
        o_Qtx   : out std_logic_vector(7 downto 0);
        o_Irx   : out std_logic_vector(7 downto 0);
        o_Qrx   : out std_logic_vector(7 downto 0);
        o_LED_rx: out std_logic_vector(1 downto 0)
    );
end T10_M3_ModA;

architecture behavioral of T10_M3_ModA is
    signal w_Itx    : std_logic_vector(7 downto 0) := x"00";
    signal w_Qtx    : std_logic_vector(7 downto 0) := x"00";
    signal w_Irx    : std_logic_vector(7 downto 0) := x"00";
    signal w_Qrx    : std_logic_vector(7 downto 0) := x"00";
    signal w_CE16_d6  : std_logic := '0';
    signal w_CE16_d10 : std_logic := '0';
    signal w_CE16_d14 : std_logic := '0';
    signal w_prn    : std_logic_vector(7 downto 0);

begin
    CE16_D6: entity work.T10_M3_CE_Delay(behavioral)
        generic map
        (
            g_ce_delay => 6
        )
        port map
        (
            i_CE => i_CE16,
            i_Clk => i_clk,
            o_CE => w_CE16_d6
        );

    CE16_D10: entity work.T10_M3_CE_Delay(behavioral)
        generic map
        (
            g_ce_delay => 10
        )
        port map
        (
            i_CE => i_CE16,
            i_Clk => i_clk,
            o_CE => w_CE16_d10
        );

    CE16_D14: entity work.T10_M3_CE_Delay(behavioral)
        generic map
        (
            g_ce_delay => 14
        )
        port map
        (
            i_CE => i_CE16,
            i_Clk => i_clk,
            o_CE => w_CE16_d14
        );

    ModulatorA: entity work.T10_M3_ModulatorA(behavioral)
        port map
        (
            i_Clk    => i_clk,
            i_CE16   => w_CE16_d6,
            i_symbol => i_symbol,
            i_Reset  => i_Reset,
            o_dataI  => w_Itx,
            o_dataQ  => w_Qtx
        );
    
    ChannelA: entity work.T10_M3_ChannelA(behavioral)
        port map
        (
            i_clk => i_clk,
            i_CE => w_CE16_d10,
            i_Itx => w_Itx,
            i_Qtx => w_Qtx,
            i_prn => w_prn,
            i_error_switch => i_error_switch,
            o_Irx => w_Irx,
            o_Qrx => w_Qrx
        );

    DemodulatorA: entity work.T10_M3_DemodulatorA(behavioral)
        port map
        (
            i_clk => i_clk,
            i_CE => w_CE16_d14,
            i_Irx => w_Irx,
            i_Qrx => w_Qrx,
            i_Reset => i_Reset,
            o_data => o_data,
            o_LED_rx => o_LED_rx
        );

    PRNG: entity work.T10_M3_PRNG256(behavioral)
        port map
        (
            i_CE => w_CE16_d6,
            o_prn => w_prn
        );

    o_Irx <= w_Irx;
    o_Qrx <= w_Qrx;
    o_Itx <= w_Itx;
    o_Qtx <= w_Qtx;
end behavioral;