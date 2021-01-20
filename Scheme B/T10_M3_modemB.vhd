library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;

-- MODEM FUNCTION: Manage input/outputs, allow management of Clocking, e.g. add buffers to clocks to handle timing issues

-- Symbol Data arrives, new symbol flag is raised in order to activate modulator
-- Modulator takes symbol and selects moddata value to use for I and Q, array of 8-bit values, dataready flag raised
-- Transmission occurs, values are sent to error channel block
-- Error Channel introduces error to values as they come in, and retransmits to demodulator
-- Demodulator recieves modulated data

entity T10_M3_modem is
  Port (i_sysClock      : in  STD_LOGIC;
        i_CE2Hz         : in  STD_LOGIC;
        i_CE250Hz       : in  STD_LOGIC;
        i_errorSelect   : in  STD_LOGIC_VECTOR(1 downto 0);
        i_Symbol        : in  STD_LOGIC_VECTOR(1 downto 0);
        o_I_Tx          : out STD_LOGIC_VECTOR(7 downto 0);
        o_Q_Tx          : out STD_LOGIC_VECTOR(7 downto 0);
        o_I_Rx          : out STD_LOGIC_VECTOR(7 downto 0);
        o_Q_Rx          : out STD_LOGIC_VECTOR(7 downto 0);
        o_data_Rx       : out STD_LOGIC_VECTOR(3 downto 0);    -- Data Value Received Out
        o_symbol_Rx     : out STD_LOGIC_VECTOR(1 downto 0)     -- Symbol Received Out
        );
end T10_M3_modem;

architecture archModem of T10_M3_modem is

 signal r_symFlag   : STD_LOGIC;
 signal r_I_Tx      : STD_LOGIC_VECTOR(7 downto 0);
 signal r_Q_Tx      : STD_LOGIC_VECTOR(7 downto 0);
 signal r_I_Rx      : STD_LOGIC_VECTOR(7 downto 0);
 signal r_Q_Rx      : STD_LOGIC_VECTOR(7 downto 0);
 signal r_data_Rx   : STD_LOGIC_VECTOR(3 downto 0);
 signal r_symbol_Rx : STD_LOGIC_VECTOR(1 downto 0);
begin

newSymProc: process (i_sysClock, i_CE2Hz)
begin
    if rising_edge(i_sysClock) then
        if i_CE2Hz = '1' then
            r_symFlag <= '1';
        end if;   
    end if;
end process newSymProc;

modulator: entity work.T10_M3_modulatorB(archModulatorB)
port map
(
    i_sysClock  => i_sysClock,
    i_CE250Hz   => i_CE250Hz,
    i_symFlag   => r_symFlag,     
    i_symInput  => i_Symbol,
    o_I_Tx      => r_I_Tx,
    o_Q_Tx      => r_Q_Tx
);

error: entity work.T10_M3_errorChannelB(archErrorChannelB)
port map
(
    i_sysClock      => i_sysClock,   
    i_CE250Hz       => i_CE250Hz,
    i_errorSelect   => i_errorSelect, 
    i_I_Tx          => r_I_Tx,
    i_Q_Tx          => r_Q_Tx,
    o_I_Rx          => r_I_Rx,
    o_Q_Rx          => r_Q_Rx
);

demodulator: entity work.T10_M3_demodulatorB(archDemodulatorB)
port map
(
    i_sysClock  => i_sysClock,
    i_I_Rx      => r_I_Rx,
    i_Q_Rx      => r_Q_Rx,
    o_data_Rx   => r_data_Rx,
    o_symbol_Rx => r_symbol_Rx
);

o_I_Tx      <= r_I_Tx;    
o_Q_Tx      <= r_Q_Tx;
o_data_Rx   <= r_data_Rx;
o_I_Rx      <= r_I_Rx;
o_Q_Rx      <= r_Q_Rx;

end archModem;
