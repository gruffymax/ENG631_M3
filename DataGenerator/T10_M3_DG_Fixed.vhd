-- Team 10 - 762102 872403
-- Version 1.0
--  Tested on :-
--  Simulated   - Yes
--  Hardware    - Yes

library IEEE;
use IEEE.std_logic_1164.all;

entity T10_M3_DG_Fixed is
    port
    (
        i_mode      : in std_logic_vector(3 downto 0);
        o_data      : out std_logic_vector(3 downto 0)
    );
end T10_M3_DG_Fixed;

architecture behavioral of T10_M3_DG_Fixed is

begin
    o_data <=   "0001" when i_mode = "0000" else
                "0111" when i_mode = "0001" else
                "1110" when i_mode = "0010" else
                "1000" when i_mode = "0011" else
                "0000";
end behavioral;