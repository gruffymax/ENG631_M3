-- Team 10 - 762102 872403
--Version 1

library IEEE;
use IEEE.std_logic_1164.all;

entity T10_M3_XNOR is
    port
    (
        i_a : in std_logic;
        i_b : in std_logic;
        o_y : out std_logic
    );
end T10_M3_XNOR;
architecture behavioral of T10_M3_XNOR is

begin
    o_y <= i_a xnor i_b after 1 ns;
end behavioral;