-- Team 10 762102
-- Version 0
-- Tested on :-
--  Simulation - No
--  Hardware   - No

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity T10_M3_CE_Delay is
    port
    (
        i_CE    : in std_logic;
        i_Clk   : in std_logic;
        o_CE    : out std_logic
    );
end T10_M3_CE_Delay;

architecture behavioral of T10_M3_CE_Delay is
    signal w_clr : std_logic := '0';
    signal w_ff0 : std_logic;
    signal w_ff1 : std_logic;
    signal w_nclk : std_logic;

begin
    ff0: entity work.T10_M3_FlipFlop(behavioral)
        port map
        (
            i_CE => w_nclk,
            i_D => i_CE,
            i_Clr => w_Clr,
            o_Q => w_ff0
        );
    ff1: entity work.T10_M3_FlipFlop(behavioral)
        port map
        (
            i_CE => w_nclk,
            i_D => w_ff0,
            i_Clr => w_clr,
            o_Q => w_ff1
        );
        
    ff2: entity work.T10_M3_FlipFlop(behavioral)
        port map
        (
            i_CE => w_nclk,
            i_D => w_ff1,
            i_Clr => w_clr,
            o_Q => o_CE
        );
    w_nclk <= not i_Clk;
end behavioral;
