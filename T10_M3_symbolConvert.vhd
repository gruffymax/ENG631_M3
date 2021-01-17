library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity T10_M3_symbolConvert is
Port ( 
        i_sysClock : in STD_LOGIC;
        i_data : in STD_LOGIC_VECTOR (3 downto 0); 
        i_CE1Hz : in STD_LOGIC;
        i_CE2Hz : in STD_LOGIC;
        o_symbol: out std_logic_vector(1 downto 0);
        o_LED_tx : out STD_LOGIC_VECTOR (1 downto 0)
);

end T10_M3_symbolConvert;

architecture archSymbolConvert of T10_M3_symbolConvert is

signal r_data0 : STD_LOGIC_VECTOR (1 downto 0);
signal r_data1 : STD_LOGIC_VECTOR (1 downto 0);
signal r_symbol : STD_LOGIC_VECTOR (3 downto 0) := "0000";
signal r_dataCount : UNSIGNED (0 downto 0) := "0";

begin 

    symbolConvertProc : process (i_sysClock, i_CE2Hz, r_data1, r_data0)
begin
    if rising_edge(i_sysClock) then
        if i_CE2Hz = '1' then
            if r_dataCount = "0" then
                r_symbol <= i_data(3 downto 2);
                o_LED_tx <= "10";

            elsif r_dataCount = "1" then
                r_symbol <= i_data(1 downto 0);
                o_LED_tx <= "01";
            end if;

            r_dataCount <= r_dataCount + 1;
        end if;
    end if;
end process symbolConvertProc;

o_symbol <= r_symbol;
end archSymbolConvert;
