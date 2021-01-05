--Team 10 - 762102 872403
-- Version 1.0
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity T10_M3_DG_Temp is
    port
    (
        o_data: out std_logic_vector(3 downto 0)
    );
end T10_M3_DG_Temp;

architecture behavioral of T10_M3_DG_Temp is

begin
    o_data <= "0000";
end behavioral;