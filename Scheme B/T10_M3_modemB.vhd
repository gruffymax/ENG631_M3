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
  Port (i_sysClock  : in  STD_LOGIC;
        i_CE2Hz     : in  STD_LOGIC;
        i_Symbol    : in  STD_LOGIC_VECTOR(1 downto 0);
        o_I_Tx      : out STD_LOGIC_VECTOR(7 downto 0);
        o_Q_Tx      : out STD_LOGIC_VECTOR(7 downto 0);
        o_dat_Tx    : out STD_LOGIC_VECTOR(7 downto 0);
        o_dat_Rx    : out STD_LOGIC_VECTOR(7 downto 0);
        o_I_Rx      : out STD_LOGIC_VECTOR(7 downto 0);
        o_Q_Rx      : out STD_LOGIC_VECTOR(7 downto 0)
        );
end T10_M3_modem;

architecture archModem of T10_M3_modem is
 signal r_symFlag   : STD_LOGIC;
 signal r_symbol    : STD_LOGIC_VECTOR(1 downto 0);

begin

modulator: entity work.T10_M3_modulatorB(archModulatorB)
port map
(
-- i_sysClock, i_SymbolFlag    
);

error: entity work.T10_M3_errorChannelB(archErrorChannelB)
port map
(
-- i_sysClock, i_I_Tx, i_Q_Tx, o_I_Rx, o_Q_Rx
);

demodulator: entity work.T10_M3_demodulatorB(archDemodulatorB)
port map
(
-- i_sysClock, i_I_Rx, i_Q_Rx, o_dat_Rx, o_
);

end archModem;
