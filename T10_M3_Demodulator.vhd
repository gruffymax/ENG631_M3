--Team 10 - 762102
--Version 0
-- Tested on :-
-- Simulation   - No
-- Hardware     - No

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.All;

entity T10_M3_Demodulator is
    port
    (
        i_clk   : in std_logic;
        i_CE    : in std_logic;
        i_Irx   : in std_logic_vector(7 downto 0);
        i_Qrx   : in std_logic_vector(7 downto 0);
        i_Reset : in std_logic;
        o_data  : out std_logic_vector(3 downto 0);
        o_symbol : out std_logic_vector(1 downto 0);
    );
end T10_M3_Demodulator;

architecture behavioral of T10_M3_Demodulator is
    -- Create State machine to clock in data, multiply-accumulate
    -- and make decision. Output data and symbol.
begin

end behavioral;