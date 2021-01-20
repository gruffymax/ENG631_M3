library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity T10_M3_demodulatorB is
Port (
    i_sysClock      : in STD_LOGIC;                         -- Clock Input
    i_CE250Hz       : in STD_LOGIC;                         --
    i_I_Rx          : in STD_LOGIC_VECTOR  (7 downto 0);    -- I transmission in
    i_Q_Rx          : in STD_LOGIC_VECTOR  (7 downto 0);    -- Q transmission in
    o_data_Rx       : out STD_LOGIC_VECTOR (3 downto 0);    -- Data Value Received Out
    o_symbol_Rx     : out STD_LOGIC_VECTOR (1 downto 0)     -- Symbol Received Out
    );
end T10_M3_demodulatorB;

architecture archDemodulatorB of T10_M3_demodulatorB is
    type t_wavArray is array (0 to 7) of STD_LOGIC_VECTOR(7 downto 0);
    signal r_wav_ref    : t_wavArray := (x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00");
    
    signal r_dataCount  : INTEGER range 0 to 7;
    signal r_data       : STD_LOGIC_VECTOR(3 downto 0);         
    signal r_symbol     : STD_LOGIC_VECTOR(1 downto 0);
    signal r_CE250_D20  : STD_LOGIC;
    signal r_dataready  : STD_LOGIC; 
    
    
    --signal r_I_mac  : STD_LOGIC_VECTOR(
    --signal r_Q_mac  :
     
begin
    CEDelay: entity work.T10_M3_CE_Delay(behavioral)
        generic map
        (
            g_ce_delay => 20 -- 200ns Delay
        )
        port map
        (
            i_Clk => i_sysClock,
            i_CE => i_CE250Hz,
            o_CE => r_CE250_D20
        );
    
    o_data_Rx <= r_data;
    o_symbol_Rx <= r_symbol;
    
    
    dataProc: process (i_sysClock)
    begin
        if rising_edge(i_sysClock) then
            if r_CE250_D20 = '1' then
                if r_dataCount = 7 then
                    r_dataCount <= 0;
                    r_dataready <= '1';
                else
                    r_dataCount <= r_dataCount + 1;                
                end if;
                r_I_Rx_in(r_dataCount) <= i_I_Rx;
                r_Q_Rx_in(r_dataCount) <= i_Q_Rx;               
            end if;
        end if;
    end process dataProc;

end archDemodulatorB;
