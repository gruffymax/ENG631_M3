-- Team 10 - 762102 872403
--Version 0

library IEEE;
use IEEE.std_logic_1164.all;

entity T10_M3_CRC_LFSR is
    port
    (
        i_CE    : in std_logic;
        i_data  : in std_logic;
        i_Clr   : in std_logic;
        o_crc   : out std_logic_vector(2 downto 0)
    );
end T10_M3_CRC_LFSR;
architecture behavioral of T10_M3_CRC_LFSR is
    signal w_ff2_Q : std_logic := '0';
    signal w_ff1_Q : std_logic := '0';
    signal w_ff0_Q : std_logic := '0';
    signal w_xor1_o : std_logic;
    signal w_xor0_o : std_logic;

begin
    xor1: entity work.T10_M3_XOR(behavioral)
        port map
        (
            i_a => i_data,
            i_b => w_ff2_Q,
            o_y => w_xor1_o
        );

    ff2: entity work.T10_M3_FlipFlop(behavioral)
        port map
        (
            o_Q => w_ff2_Q,
            i_D => w_ff1_Q,
            i_CE => i_CE,
            i_Clr => i_Clr
        );

    ff1: entity work.T10_M3_FlipFlop(behavioral)
        port map
        (
            o_Q => w_ff1_Q,
            i_D => w_xor0_o,
            i_CE => i_CE,
            i_Clr => i_Clr
        );

    ff0: entity work.T10_M3_FlipFlop(behavioral)
        port map
        (
            o_Q => w_ff0_Q,
            i_D => w_xor1_o,
            i_CE => i_CE,
            i_Clr => i_Clr
        );
    
    xor0: entity work.T10_M3_XOR(behavioral)
        port map
        (
            i_a => w_ff0_Q,
            i_b => w_xor1_o,
            o_y => w_xor0_o
        );

    o_crc(2) <= w_ff2_Q after 1 ns;
    o_crc(1) <= w_ff1_Q after 1 ns;
    o_crc(0) <= w_ff0_Q after 1 ns;
end behavioral;
