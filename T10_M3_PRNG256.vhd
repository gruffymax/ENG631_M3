-- Team 10 - 762102 872403
--Version 1
-- Tested on :-
--  Simulation  - Yes
--  Hardware    - No

library IEEE;
use IEEE.std_logic_1164.all;

entity T10_M3_PRNG256 is
    port
    (
        i_CE    : in std_logic;
        i_clr   : in std_logic;
        o_prn   : out std_logic_vector(7 downto 0)
    );
end T10_M3_PRNG256;

architecture behavioral of T10_M3_PRNG256 is
    signal w_xnor0_o : std_logic;
    signal w_xnor1_o : std_logic;
    signal w_xnor2_o : std_logic;
    signal w_ff0_Q  : std_logic := '0';
    signal w_ff1_Q  : std_logic := '0';
    signal w_ff2_Q  : std_logic := '0';
    signal w_ff3_Q  : std_logic := '0';
    signal w_ff4_Q  : std_logic := '0';
    signal w_ff5_Q  : std_logic := '0';
    signal w_ff6_Q  : std_logic := '0';
    signal w_ff7_Q  : std_logic := '0';

begin
    ff0: entity work.T10_M3_FlipFlop(behavioral)
    port map
    (
        o_Q => w_ff0_Q,
        i_D => w_xnor2_o,
        i_clr => i_clr,
        i_CE => i_CE
    );

    ff1: entity work.T10_M3_FlipFlop(behavioral)
        port map
        (
            o_Q => w_ff1_Q,
            i_D => w_ff0_Q,
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

    ff6: entity work.T10_M3_FlipFlop(behavioral)
        port map
        (
            o_Q => w_ff6_Q,
            i_D => w_ff5_Q,
            i_clr => i_clr,
            i_CE => i_CE
        );

    ff7: entity work.T10_M3_FlipFlop(behavioral)
        port map
        (
            o_Q => w_ff6_Q,
            i_D => w_ff7_Q,
            i_clr => i_clr,
            i_CE => i_CE
        );

    xnor0: entity work.T10_M3_XNOR(behavioral)
        port map
        (
            i_a => w_ff7_Q,
            i_b => w_ff5_Q,
            o_y => w_xnor0_o
        );

    xnor1: entity work.T10_M3_XNOR(behavioral)
        port map
        (
            i_a => w_ff4_Q,
            i_b => w_ff3_Q,
            o_y => w_xnor1_o
        );

    xnor2: entity work.T10_M3_XNOR(behavioral)
        port map
        (
            i_a => w_xnor0_o,
            i_b => w_xnor1_o,
            o_y => w_xnor2_o
        );

    o_prn(7) <= w_ff7_Q;
    o_prn(6) <= w_ff6_Q;
    o_prn(5) <= w_ff5_Q;
    o_prn(4) <= w_ff4_Q;
    o_prn(3) <= w_ff3_Q;
    o_prn(2) <= w_ff2_Q;
    o_prn(1) <= w_ff1_Q;
    o_prn(0) <= w_ff0_Q;
end behavioral;