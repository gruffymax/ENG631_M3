library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;

entity T10_M3_modulatorB is
Port ( 
    i_sysClock      : in    STD_LOGIC;                       -- Clock Input
    i_symFlag       : inout STD_LOGIC;                       -- New Symbol Flag
    i_symInput      : in    STD_LOGIC_VECTOR(1 downto 0);
    o_I_Tx          : out   STD_LOGIC_VECTOR(7 downto 0);
    o_Q_Tx          : out   STD_LOGIC_VECTOR(7 downto 0)
    );
end T10_M3_modulatorB;

architecture archModulatorB of T10_M3_modulatorB is
    type t_modArray is array (0 to 7) of STD_LOGIC_VECTOR(7 downto 0);
   
    signal r_mod_zero  : t_modArray := (x"80",x"A0",x"C0",x"A0",x"80",x"60",x"40",x"20");
    signal r_mod_one   : t_modArray := (x"80",x"60",x"40",x"60",x"80",x"A0",x"C0",x"A0");
    signal r_mod_null  : t_modArray := (others => "10000000");
    signal r_mod_start : t_modArray := (others => "11000000");
    signal r_mod_stop  : t_modArray := (others => "01000000");
    
    signal r_IArray    : t_modArray;
    signal r_QArray    : t_modArray;
    
    signal r_dataReady : STD_LOGIC;
    signal r_modCount  : STD_LOGIC_VECTOR(2 downto 0);
    
begin
    
    dataSelectProc: process (i_sysClock, i_symFlag)
    begin
        if rising_edge(i_sysClock) then
            if i_symFlag = '1' then
                case i_symInput is
                    when "00" =>        -- I = 0 , Q = Null
                        r_IArray <= r_mod_zero;
                        r_QArray <= r_mod_null;
                        i_symFlag <= '0';
                        r_dataReady <= '1';
                        
                    when "10" =>        -- I = Null, Q = 0
                        r_IArray <= r_mod_null;
                        r_QArray <= r_mod_zero;
                        i_symFlag <= '0';
                        r_dataReady <= '1';
                        
                    when "11" =>        -- I = 1, Q = Null
                        r_IArray <= r_mod_one;
                        r_QArray <= r_mod_null;
                        i_symFlag <= '0';
                        r_dataReady <= '1';
                        
                    when "01" =>        -- I = Null, Q = 1
                        r_IArray <= r_mod_null;
                        r_QArray <= r_mod_one;
                        i_symFlag <= '0';
                        r_dataReady <= '1';                
                end case;
            end if;    
        end if;
    end process dataSelectProc;
    
    modTxProc: process (i_sysClock, r_dataReady)
    begin
        if rising_edge(i_sysClock) then
            if r_dataReady = '1' then
                
            end if;
        end if;
    end process modTxProc; 

end archModulatorB;
