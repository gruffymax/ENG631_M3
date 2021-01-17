--Team 10 - 762102 872403
-- Version 1.0
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity T10_M3_mux2to1 is
    Port
    (  
        i_signal1       : in STD_LOGIC;
        i_signal2       : in STD_LOGIC;
        i_sw0           : in STD_LOGIC;
        o_signalOut     : out STD_LOGIC
    );
end T10_M3_mux2to1;

architecture behavioral of T10_M3_mux2to1 is
begin
    --Select output depending on state of i_select
    o_signalOut <=  i_signal2 when i_sw0 = '1' else
                    i_signal1;
end behavioral;
