library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity T10_M3_demodulatorB is
Port (
    i_sysClock      : in STD_LOGIC;                         -- Clock Input
    i_CE250Hz       : in STD_LOGIC;                         -- 250Hz Clock Enable
    i_I_Rx          : in STD_LOGIC_VECTOR  (7 downto 0);    -- I transmission in
    i_Q_Rx          : in STD_LOGIC_VECTOR  (7 downto 0);    -- Q transmission in
    o_data_Rx       : out STD_LOGIC_VECTOR (3 downto 0)    -- Data Value Received Out
    );
end T10_M3_demodulatorB;

architecture archDemodulatorB of T10_M3_demodulatorB is
    type t_wavArray is array (0 to 7) of INTEGER;
    signal r_wav_ref    : t_wavArray := (0,1,1,1,0,-1,-1,-1);                     
    
    signal r_I_Sum      :   INTEGER     := 0;                           -- mac value of I
    signal r_Q_Sum      :   INTEGER     := 0;                           -- mac value of Q
    signal r_dataready  :   STD_LOGIC   := '0';                         -- Flag for when modulated data has been 'mac'ed
    signal r_dataCount  :   INTEGER range 0 to 7 := 0;                  -- Counts in the received symbols
    signal r_symCount   :   INTEGER range 0 to 1 := 0;                  -- Count for low or high symbol
    signal r_data       :   STD_LOGIC_VECTOR(3 downto 0) := "0000";     -- Assemble Symbols
    signal r_data_Rx    :   STD_LOGIC_VECTOR(3 downto 0) := "0000";     -- For writing to output  
    signal r_symbol_0   :   STD_LOGIC_VECTOR(1 downto 0);       -- First Symbol
    signal r_symbol_1   :   STD_LOGIC_VECTOR(1 downto 0);
    signal r_CE250_D20  :   STD_LOGIC;
    
begin
    --------------- ENTITIES ---------------
    CEDelay: entity work.T10_M3_CE_Delay(behavioral)
        generic map
        (   g_ce_delay => 20) -- 200ns Clock Enable Delay
        port map
        (   i_Clk => i_sysClock,
            i_CE => i_CE250Hz,
            o_CE => r_CE250_D20);
            
    --------------- PROCESSES ---------------
    
    dataProc: process (i_sysClock)
        -- Performs the multiply and accumulate on 
    begin
        if rising_edge(i_sysClock) then
            if r_CE250_D20 = '1' then
                if r_dataCount = 7 then
                    r_dataCount <= 0;
                    r_dataready <= '1';
                else
                    r_dataCount <= r_dataCount + 1;                
                end if;
                r_I_Sum <= r_I_Sum + (r_wav_ref(r_dataCount) * to_integer(unsigned(i_I_Rx)));
                r_Q_Sum <= r_Q_Sum + (r_wav_ref(r_dataCount) * to_integer(unsigned(i_Q_Rx)));
            end if;
        end if;
    end process dataProc;
    
    compProc: process (i_sysClock)
    begin
        if rising_edge(i_sysClock) then          
            if r_dataReady = '1' then
               if r_symCount = 1 then
                    r_symCount <= 0;
               else
                    r_symCount <= 1;
               end if;
               
                if r_symCount = 0 then
                    if r_I_Sum > r_Q_Sum then
                        -- 00 or 01
                        if r_I_Sum > 150 then
                            r_symbol_0 <= "00";
                        elsif r_I_Sum < -150 then
                            r_symbol_0 <= "01";
                        end if;
                     elsif r_Q_Sum > r_I_Sum then
                        -- 10 or 11
                        if r_Q_Sum > 150 then
                            r_symbol_0 <= "10";
                        elsif r_Q_Sum < -150 then
                            r_symbol_0 <= "11";
                        end if;
                     end if;
                 
             elsif r_symCount = 1 then
                    if r_I_Sum > r_Q_Sum then
                        -- 00 or 01
                        if r_I_Sum > 150 then
                            r_symbol_1 <= "00";
                        elsif r_I_Sum < -150 then
                            r_symbol_0 <= "01";
                        end if;
                     elsif r_Q_Sum > r_I_Sum then
                        -- 10 or 11
                        if r_Q_Sum > 150 then
                            r_symbol_1 <= "10";
                        elsif r_Q_Sum < -150 then
                            r_symbol_1 <= "11";
                        end if;   
                    end if;
             end if;
            end if;
        end if;
    end process compProc;
    
    o_data_Rx(1 downto 0)   <= r_symbol_1;
    o_data_Rx(3 downto 2)   <= r_symbol_0;
    
end archDemodulatorB;
