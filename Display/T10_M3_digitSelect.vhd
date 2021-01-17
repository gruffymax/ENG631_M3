--Team 10 - 762102 872403
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity T10_M3_digitSelect is
    Port ( 
           i_Reset : in STD_LOGIC;
           i_sysClock : in STD_LOGIC;
           i_BCDInput0 : in STD_LOGIC_VECTOR (3 downto 0);      -- Input 0 from Binary to BCD converter,
           i_BCDInput1 : in STD_LOGIC_VECTOR (3 downto 0);      -- Input 1 from Binary to BCD converter,
           i_BCDInput2 : in STD_LOGIC_VECTOR (3 downto 0);      -- Input 2 from Binary to BCD converter,
           i_BCDInput3 : in STD_LOGIC_VECTOR (3 downto 0);      -- Input 3 from Binary to BCD converter,
           i_scanCount : in STD_LOGIC_VECTOR (1 downto 0);      -- Counter value to control anode selection,
           
           o_BCDBuffer : out STD_LOGIC_VECTOR (3 downto 0) := (others => '0');     -- Output to r_BCDBuffer the current 4-bits of the BCD Input Array,
           o_segmentAnode : out STD_LOGIC_VECTOR (3 downto 0) := (others => '0') -- Output to AN3:0 pins, Anodes are ACTIVE LOW.
           );
end T10_M3_digitSelect;

architecture archDigitSelect of T10_M3_digitSelect is
    
begin
    digitSelectProc: process ( i_Reset, i_sysClock, i_scanCount)
    begin
        if i_Reset = '1' then
                o_BCDBuffer <= "0000";
                o_SegmentAnode <= "0000";   
        elsif rising_edge(i_sysClock) then
            case i_scanCount is
                when "00" =>        -- LSD selected
                    o_segmentAnode <= "1110";
                    o_BCDBuffer <= i_BCDInput0;
                when "01" =>        -- second LSD selected
                    o_segmentAnode <= "1101";
                    o_BCDBuffer <= i_BCDInput1;
                when "10" =>        -- second MSD selected
                    o_segmentAnode <= "1011";
                    o_BCDBuffer <= i_BCDInput2;
                when "11" =>        -- MSD selected
                    o_segmentAnode <= "0111";
                    o_BCDBuffer <= i_BCDInput3;
                when others =>
                    o_segmentAnode <= "0000";
                    o_BCDBuffer <= "0000";
             end case;
        end if;
    
end process digitSelectProc;

end archDigitSelect;
