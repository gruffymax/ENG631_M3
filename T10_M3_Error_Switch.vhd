--Team 10 - 762102 872403
-- Version 1.0
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity T10_M3_Error_Switch is
    port
    (
        i_sw10  : in std_logic;
        i_sw11  : in std_logic;
        o_error_switch  : out std_logic_vector(1 downto 0)
    );
end T10_M3_Error_Switch;

architecture behavioral of T10_M3_Error_Switch is

begin
    o_error_switch(1) <= i_sw11;
    o_error_switch(0) <= i_sw10;
end behavioral;