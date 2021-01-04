-- Team 10 - 762102 872403
--Version 1

library IEEE;
use IEEE.std_logic_1164.all;

entity T10_M3_PRNG16 is
    port
    (
        i_CE    : in std_logic;
        i_clr   : in std_logic;
        o_prn   : out std_logic_vector(4 downto 0)
    );
end T10_M3_PRNG16;

architecture behavioral of T10_M3_PRNG16 is
    signal w_xnor_o : std_logic;
    signal w_ff1_Q  : std_logic := '1';
    signal w_ff2_Q  : std_logic := '1';
    signal w_ff3_Q  : std_logic := '1';
    signal w_ff4_Q  : std_logic := '0';
    signal w_ff5_Q  : std_logic := '0';
begin
    ff1: entity work.T10_M3_FlipFlop(behavioral)
        port map
        (
            o_Q => w_ff1_Q,
            i_D => w_xnor_o,
            i_clr => i_clr,
            i_CE => i_CE
        );

    ff2: entity work.T10_M3_FlipFlop(behavioral)
        port map
        (
            o_Q => w_ff2_Q,
            i_D => w_ff1_Q,
            i_clr => i_clr,
            i_CE => i_CE
        );

    ff3: entity work.T10_M3_FlipFlop(behavioral)
        port map
        (
            o_Q => w_ff3_Q,
            i_D => w_ff2_Q,
            i_clr => i_clr,
            i_CE => i_CE
        );

    ff4: entity work.T10_M3_FlipFlop(behavioral)
        port map
        (
            o_Q => w_ff4_Q,
            i_D => w_ff3_Q,
            i_clr => i_clr,
            i_CE => i_CE
        );
        
    ff5: entity work.T10_M3_FlipFlop(behavioral)
        port map
        (
            o_Q => w_ff5_Q,
            i_D => w_ff4_Q,
            i_clr => i_clr,
            i_CE => i_CE
        );

    xnor1: entity work.T10_M3_XNOR(behavioral)
        port map
        (
            i_a => w_ff3_Q,
            i_b => w_ff5_Q,
            o_y => w_xnor_o
        );

    o_prn(4) <= w_ff5_Q;
    o_prn(3) <= w_ff4_Q;
    o_prn(2) <= w_ff3_Q;
    o_prn(1) <= w_ff2_Q;
    o_prn(0) <= w_ff1_Q;
end behavioral;