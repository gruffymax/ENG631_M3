library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;

entity T10_M3_modulatorB is
Port ( 
    i_sysClock      : in    STD_LOGIC;                       -- Clock Input
    i_CE250Hz       : in    STD_LOGIC;
    i_CE2Hz         : in    STD_LOGIC;                          
    i_symInput      : in    STD_LOGIC_VECTOR(1 downto 0);
    
    o_I_Tx          : out   STD_LOGIC_VECTOR(7 downto 0);
    o_Q_Tx          : out   STD_LOGIC_VECTOR(7 downto 0)
    );
end T10_M3_modulatorB;

architecture archModulatorB of T10_M3_modulatorB is

    type t_modArray is array (7 downto 0) of STD_LOGIC_VECTOR(7 downto 0);
       
    signal r_mod_zero   : t_modArray := (x"80",x"A0",x"C0",x"A0",x"80",x"60",x"40",x"20");    
    signal r_mod_one    : t_modArray := (x"80",x"60",x"40",x"60",x"80",x"A0",x"C0",x"A0");
    signal r_mod_null   : t_modArray := (others => "10000000");
    signal r_mod_start  : t_modArray := (others => "11000000");
    signal r_mod_stop   : t_modArray := (others => "01000000");
    
    signal r_IArray    : t_modArray := (others => x"00");
    signal r_QArray    : t_modArray := (others => x"00");
    signal r_I_Tx      : STD_LOGIC_VECTOR(7 downto 0);
    signal r_Q_Tx      : STD_LOGIC_VECTOR(7 downto 0);
    shared variable r_dataReady : STD_LOGIC;
    signal r_CE2_D5    : STD_LOGIC;
    signal r_modCount  : INTEGER range 0 to 7;
    
begin
    
    CEDelay: entity work.T10_M3_CE_Delay(behavioral)
        generic map
        (   g_ce_delay => 5) -- 50ns Clock Enable Delay
        port map
        (   i_Clk => i_sysClock,
            i_CE => i_CE2Hz,
            o_CE => r_CE2_D5);
    
    dataSelectProc: process (i_sysClock)
    begin
        if rising_edge(i_sysClock) then 
            if r_CE2_D5 = '1' then
                case i_symInput is
                    when "00" =>        -- I = 0 , Q = Null
                        r_IArray    <= r_mod_zero;
                        r_QArray    <= r_mod_null;
                        r_dataReady := '1';
                        
                    when "10" =>        -- I = Null, Q = 0
                        r_IArray    <= r_mod_null;
                        r_QArray    <= r_mod_zero;
                        r_dataReady := '1';
                        
                    when "11" =>        -- I = 1, Q = Null
                        r_IArray    <= r_mod_one;
                        r_QArray    <= r_mod_null;
                        r_dataReady := '1';
                        
                    when "01" =>        -- I = Null, Q = 1
                        r_IArray    <= r_mod_null;
                        r_QArray    <= r_mod_one;
                        r_dataReady := '1';
                    when others =>
                        r_IArray    <= (others => x"00");
                        r_QArray    <= (others => x"00");
                        r_dataReady := '0';                    
                end case;
            end if;    
        end if;
    end process dataSelectProc;
    
    modTxProc: process (i_sysClock)
    begin
        if rising_edge(i_sysClock) then
            if i_CE250Hz = '1' then
                if r_dataReady = '1' then
                    if r_modCount = 7 then
                       r_modCount <= 0;
                       r_dataReady :='0';
                    else
                       r_modCount <= r_modCount + 1;                       
                    end if;
                    r_I_Tx <= r_IArray(r_modCount);
                    r_Q_Tx <= r_QArray(r_modCount);                   
                end if;
             end if;
         end if;
    end process modTxProc; 
    
    o_I_Tx <= r_I_Tx;
    o_Q_Tx <= r_Q_Tx;

end archModulatorB;
