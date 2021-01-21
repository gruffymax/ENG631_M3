library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity T10_M3_errorChannelB is
Port (
        i_sysClock          : in  STD_LOGIC;                         -- Clock Input
        i_CE250Hz           : in  STD_LOGIC;
        i_errorSelect       : in  STD_LOGIC_VECTOR (1 downto 0);     -- Error Select Switch Input
        i_I_Tx              : in  STD_LOGIC_VECTOR (7 downto 0);     -- I transmission in
        i_Q_Tx              : in  STD_LOGIC_VECTOR (7 downto 0);     -- Q transmission in
        o_I_Rx              : out STD_LOGIC_VECTOR (7 downto 0);     -- Error induced I transmission out
        o_Q_Rx              : out STD_LOGIC_VECTOR (7 downto 0)      -- Error induced Q transmission out
        );
end T10_M3_errorChannelB;

architecture archErrorChannelB of T10_M3_errorChannelB is

    signal r_errorI         : UNSIGNED(7 downto 0):= x"00";                 -- I with error added
    signal r_errorQ         : UNSIGNED(7 downto 0):= x"00";                 -- Q with error added 
    signal r_rand           : STD_LOGIC_VECTOR(7 downto 0):= x"00";
    signal r_CE250_D10      : STD_LOGIC;
    
begin
    
    CEDelay: entity work.T10_M3_CE_Delay(behavioral)
        generic map
        (
            g_ce_delay => 10 -- 100ns Delay
        )
        port map
        (
            i_Clk => i_sysClock,
            i_CE => i_CE250Hz,
            o_CE => r_CE250_D10
        );
             
     prngProc: entity work.T10_M3_PRNG256(behavioral)
        port map
        (
            i_CE  => i_CE250Hz,
            o_prn => r_rand
        );
        
    
    errorProc : process (i_sysClock, r_CE250_D10)
    begin
        if rising_edge(i_sysClock) then
            if r_CE250_D10 = '1' then
                case i_errorSelect is
                    when "00" =>    -- No error added
                            r_errorI <= unsigned(i_I_Tx);
                            r_errorQ <= unsigned(i_Q_Tx);
                    when "01" =>    -- +-16
                        if r_rand(4) = '0' then
                            r_errorI <= (unsigned(i_I_Tx)) + (unsigned(r_rand(3 downto 0)));
                            r_errorQ <= (unsigned(i_Q_Tx)) + (unsigned(r_rand(3 downto 0)));
                        else
                            r_errorI <= (unsigned(i_I_Tx)) - (unsigned(r_rand(3 downto 0)));
                            r_errorQ <= (unsigned(i_Q_Tx)) - (unsigned(r_rand(3 downto 0)));
                        end if;
                    when "10" =>    -- +-32
                        if r_rand(5) = '0' then
                            r_errorI <= (unsigned(i_I_Tx)) + (unsigned(r_rand(4 downto 0)));
                            r_errorQ <= (unsigned(i_Q_Tx)) + (unsigned(r_rand(4 downto 0)));
                        else
                            r_errorI <= (unsigned(i_I_Tx)) - (unsigned(r_rand(4 downto 0)));
                            r_errorQ <= (unsigned(i_Q_Tx)) - (unsigned(r_rand(4 downto 0)));
                        end if;
                    when "11" =>    -- +-64
                        if r_rand(6) = '0' then
                            r_errorI <= (unsigned(i_I_Tx)) + (unsigned(r_rand(5 downto 0)));
                            r_errorQ <= (unsigned(i_Q_Tx)) + (unsigned(r_rand(5 downto 0)));
                        else
                            r_errorI <= (unsigned(i_I_Tx)) - (unsigned(r_rand(5 downto 0)));
                            r_errorQ <= (unsigned(i_Q_Tx)) - (unsigned(r_rand(5 downto 0)));
                        end if;
                    when others =>
                            r_errorI <= x"00";
                            r_errorQ <= x"00";           
                end case;
            end if;
        end if;
    end process;
 
    o_I_Rx <= std_logic_vector(r_errorI);
    o_Q_Rx <= std_logic_vector(r_errorQ);
     
end archErrorChannelB;
