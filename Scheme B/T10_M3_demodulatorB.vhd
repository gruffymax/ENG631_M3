library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;

entity T10_M3_demodulatorB is
Port (
    i_sysClock      : in STD_LOGIC;                         -- Clock Input
    i_I_Rx          : in STD_LOGIC_VECTOR  (7 downto 0);    -- I transmission in
    i_Q_Rx          : in STD_LOGIC_VECTOR  (7 downto 0);    -- Q transmission in
    o_data_Rx       : out STD_LOGIC_VECTOR (3 downto 0);    -- Data Value Received Out
    o_symbol_Rx     : out STD_LOGIC_VECTOR (1 downto 0)     -- Symbol Received Out
    );
end T10_M3_demodulatorB;

architecture archDemodulatorB of T10_M3_demodulatorB is

    signal r_data   : STD_LOGIC_VECTOR(3 downto 0);         
    signal r_symbol : STD_LOGIC_VECTOR(1 downto 0);
    --signal r_I_mac  : STD_LOGIC_VECTOR(
    --signal r_Q_mac  :
     
begin

    
    o_data_Rx <= r_data;
    o_symbol_Rx <= r_symbol;

end archDemodulatorB;
