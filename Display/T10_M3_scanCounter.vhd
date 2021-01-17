--Team 10 - 762102 872403
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;  -- for unsigned counter value

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity T10_M3_scanCounter is
    Port ( 
           i_sysClock : in STD_LOGIC;
           i_Reset : in STD_LOGIC;
           i_clockEnable : in STD_LOGIC;
           
           o_scanCount : out STD_LOGIC_VECTOR (1 downto 0)
           );

end T10_M3_scanCounter;

architecture archScanCounter of T10_M3_scanCounter is
-- Counter for segment anode selection
    signal r_scanCount : UNSIGNED (1 downto 0) := (others => '0');
    
begin
    scanCountProc: process(i_Reset, i_sysClock, i_clockEnable)
    begin
        if i_Reset = '1' then
            r_scanCount <= (others => '0');
        elsif rising_edge(i_sysClock) then
            if i_clockEnable = '1' then
                r_scanCount <= r_scanCount + 1; --bitwise vector, no counter reset required as counter rolls over  
            end if;
        end if;
    end process scanCountProc;
    
    o_scanCount <= std_logic_vector(r_scanCount);  -- conversion required between SLV and unsigned
   
end archScanCounter;
