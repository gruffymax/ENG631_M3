--Team 10 - 762102 872403
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use ieee.numeric_std.all;

entity T10_M3_displayDriver is
Port (
    i_sysClock       : in STD_LOGIC;                        -- Clock Input
    i_Reset          : in STD_LOGIC;                        -- Reset Input
    i_CE250Hz        : in STD_LOGIC;                        -- 250Hz Clock Enable Signal Input
    i_BCDInput0      : in STD_LOGIC_VECTOR (3 downto 0);    -- Register for input 0 from Binary to BCD converter
    i_BCDInput1      : in STD_LOGIC_VECTOR (3 downto 0);    -- Register for input 1 from Binary to BCD converter
    i_BCDInput2      : in STD_LOGIC_VECTOR (3 downto 0);    -- Register for input 2 from Binary to BCD converter
    i_BCDInput3      : in STD_LOGIC_VECTOR (3 downto 0);    -- Register for input 3 from Binary to BCD converter
    o_SegmentCathode : out STD_LOGIC_VECTOR(6 downto 0);    -- Output to Seven Segment Cathodes
    o_SegmentAnode   : out STD_LOGIC_VECTOR(3 downto 0)     -- Output to Segment Anodes
    
     );
end T10_M3_displayDriver;

architecture archDisplayDriver of T10_M3_displayDriver is
-- signal declaration
    signal r_BCDBuffer : STD_LOGIC_VECTOR( 3 downto 0);     -- Buffer from digitSelect to segmentDecode
    signal r_scanCount : STD_LOGIC_VECTOR(1 downto 0);

    
begin
        
    -- segmentDecode instantiation
    segmentDecode: entity work.T10_M3_segmentDecode(archSegmentDecode)
        Port map (i_BCDBuffer => r_BCDBuffer, o_SegmentCathode => o_SegmentCathode);
    
    -- digitSelect instantiation
    digitSelect: entity work.T10_M3_digitSelect(archDigitSelect)
        Port map (i_Reset => i_Reset,
                  i_sysClock  => i_sysClock,
                  i_BCDInput0 => i_BCDInput0,         -- Input 0 from Binary to BCD converter,
                  i_BCDInput1 => i_BCDInput1,         -- Input 1 from Binary to BCD converter,
                  i_BCDInput2 => i_BCDInput2,         -- Input 2 from Binary to BCD converter,
                  i_BCDInput3 => i_BCDInput3,         -- Input 3 from Binary to BCD converter,
                  i_scanCount => r_scanCount,         -- Counter value to control anode selection
                  o_BCDBuffer => r_BCDBuffer,         -- Output to r_BCDBuffer the current 4-bits of the BCD Input Array
                  o_segmentAnode => o_segmentAnode);  -- Output to AN3:0 pins);
    
    scanCounter: entity work.T10_M3_scanCounter(archScanCounter)
        Port map( 
           i_sysClock => i_sysClock,
           i_Reset => i_Reset,
           i_clockEnable => i_CE250Hz,
           o_scanCount => r_scanCount);
    
    

end archDisplayDriver;
