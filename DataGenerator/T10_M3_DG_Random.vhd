--Team 10 762102 872403

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity T10_M3_DG_Random is
    port
    (
        i_CE    : in std_logic;
        o_rand  : out std_logic_vector(3 downto 0)
    );
end T10_M3_DG_Random;

architecture behavioral of T10_M3_DG_Random is
    signal w_clr : std_logic := '1';
begin
    state: process(i_CE)
    begin
        if (rising_edge(i_CE)) then
            w_clr <= '0';
        end if;
    end process state;

    prng: entity work.T10_M3_PRNG16(behavioral)
        port map
        (
            i_CE => i_CE,
            i_clr => w_clr,
            o_prn => o_rand
        );
end behavioral;