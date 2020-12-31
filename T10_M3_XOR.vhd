-- Team 10 - 762102 872403
--Version 1

library IEEE;
use IEEE.std_logic_1164.all;

entity T10_M3_XOR is
    port
    (
        i_a : in std_logic;
        i_b : in std_logic;
        o_y : out std_logic
    );
end T10_M3_XOR;
architecture behavioral of T10_M3_XOR is

begin
    o_y <= i_a xor i_b;
end behavioral;