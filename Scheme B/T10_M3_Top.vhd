library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;

entity T10_M3_Top is
--  Port ( );
end T10_M3_Top;

architecture arch_top of T10_M3_Top is

begin
modem: entity work.T10_M3_modem(archModem)
port map
(

);

end arch_top;
