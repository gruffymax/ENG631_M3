library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity T10_M3_errorChannelB is
Port (
        i_sysClock          : in  STD_LOGIC;                         -- Clock Input
        i_errorSelect       : in  STD_LOGIC_VECTOR (1 downto 0);     -- Error Select Switch Input
        i_I_Tx              : in  STD_LOGIC_VECTOR (7 downto 0);     -- I transmission in
        i_Q_Tx              : in  STD_LOGIC_VECTOR (7 downto 0);     -- Q transmission in
        o_I_Rx              : out STD_LOGIC_VECTOR (7 downto 0);     -- Error induced I transmission out
        o_Q_Rx              : out STD_LOGIC_VECTOR (7 downto 0)      -- Error induced Q transmission out
        );
end T10_M3_errorChannelB;

architecture archErrorChannelB of T10_M3_errorChannelB is

    signal r_errorValue     : UNSIGNED(7 downto 0):= x"00";                 -- Random Number to be added to the transmission
    signal r_errorI         : UNSIGNED(7 downto 0):= x"00";                 -- I with error added
    signal r_errorQ         : UNSIGNED(7 downto 0):= x"00";                 -- Q with error added
    signal r_I              : UNSIGNED(7 downto 0):= x"00";                  
    signal r_Q              : UNSIGNED(7 downto 0):= x"00";
    
    signal r_rand           : UNSIGNED(7 downto 0) := x"00";
    
begin
    
    errorProc : process (i_sysClock)
    begin
        case i_errorSelect is
            when "00" =>    -- No error added
                r_errorValue <= x"00";
            when "01" =>    -- +-16
                
            when "10" =>    -- +-32
                
            when "11" =>    -- +-64               
        end case;
    end process;
    
    errorAddProc : process (i_sysClock)  
    begin
        if rising_edge(i_sysClock) then
        
            r_errorI <= r_I + r_errorValue;
            r_errorQ <= r_Q + r_errorValue;
        end if;
    end process;

    
    
    o_I_Rx <= std_logic_vector(r_errorI);
    o_Q_Rx <= std_logic_vector(r_errorQ);
     
end archErrorChannelB;
