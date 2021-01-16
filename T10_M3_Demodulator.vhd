--Team 10 - 762102
--Version 0
-- Tested on :-
-- Simulation   - No
-- Hardware     - No

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.All;

entity T10_M3_Demodulator is
    port
    (
        i_clk   : in std_logic;
        i_CE    : in std_logic;
        i_Irx   : in std_logic_vector(7 downto 0);
        i_Qrx   : in std_logic_vector(7 downto 0);
        i_Reset : in std_logic;
        o_data  : out std_logic_vector(3 downto 0);
        o_symbol : out std_logic_vector(1 downto 0)
    );
end T10_M3_Demodulator;

architecture behavioral of T10_M3_Demodulator is
    type state_t is (st_idle, st_latch, st_mac, st_output_symbol, st_output_data);
    signal r_current_state : state_t := st_idle;

    type ref_waveform_t is array(0 to 7) of integer range 0 to 1;
    constant c_ref_waveform : ref_waveform_t := (0,0,1,0,0,0,0,0);
    
    signal r_symbol_n : unsigned(0 downto 0) := "0";      -- Flag to indicate which symbol
    signal r_symbol_0 : std_logic_vector(1 downto 0) := "00";   
    signal r_symbol_1 : std_logic_vector(1 downto 0) := "00";
    signal r_data     : std_logic_vector(3 downto 0) := "0000";

    signal r_count : integer := 0;
    signal r_Irx : std_logic_vector(7 downto 0) := x"00";
    signal r_Qrx : std_logic_vector(7 downto 0) := x"00";
    signal r_macI : integer range -255 to 255 := 0;
    signal r_macQ : integer range -255 to 255 := 0;

begin
    stateMachine: process(i_Clk, i_Reset)
    begin
        if (i_Reset = '1') then
            r_count <= 0;
            r_current_state <= st_idle;
            r_macI <= 0;
            r_macQ <= 0;
            r_symbol_n <= "0";
        elsif (rising_edge(i_Clk)) then
            case r_current_state is
                when st_idle =>
                    if (i_CE = '1') then
                        r_current_state <= st_latch;
                    end if;
                
                when st_latch =>
                -- Latch inputs into registers
                    r_Irx <= i_Irx;
                    r_Qrx <= i_Qrx;
                    r_current_state <= st_mac;
                
                when st_mac =>
                -- Multiply/accumulate process
                    if (r_count = 7) then
                        r_count <= 0;
                        r_current_state <= st_output_symbol;
                    else
                        r_macI <= r_macI + (c_ref_waveform(r_count) * to_integer(unsigned(r_Irx)));
                        r_macQ <= r_macQ + (c_ref_waveform(r_count) * to_integer(unsigned(r_Qrx)));
                        r_count <= r_count + 1;
                        r_current_state <= st_idle;
                    end if;

                when st_output_symbol =>
                    -- Match I 
                    if (r_macI >= 128) then
                        if (r_symbol_n = "0") then
                            r_symbol_0(1) <= '0';
                        else
                            r_symbol_1(1) <= '0';
                        end if;
                    else
                        if (r_symbol_n = "0") then
                            r_symbol_0(1) <= '1';
                        else
                            r_symbol_1(1) <= '1';
                        end if;
                    end if;

                    -- Match Q
                    if (r_macQ >= 128) then
                        if (r_symbol_n = "0") then
                            r_symbol_0(0) <= '0';
                        else
                            r_symbol_1(0) <= '0';
                        end if;
                    else
                        if (r_symbol_n = "0") then
                            r_symbol_0(0) <= '1';
                        else
                            r_symbol_1(0) <= '1';
                        end if;
                    end if;

                    -- Increment symbol flag
                    r_symbol_n <= r_symbol_n + 1;
                    
                    if (r_symbol_n = "1") then
                        r_current_state <= st_output_data;
                    else
                        r_current_state <= st_idle;
                    end if;

                    -- Reset values
                    r_macI <= 0;
                    r_macQ <= 0;
                    r_count <= 0;
                    
                when st_output_data =>
                    -- Output data
                    r_data(3 downto 2) <= r_symbol_0;
                    r_data(1 downto 0) <= r_symbol_1;
                    r_current_state <= st_idle;
            end case;
        end if;
    end process stateMachine;

    outputData: process(i_Clk)
    begin
        if (falling_edge(i_Clk)) then
            if (r_symbol_n = "0") then
                o_data <= r_data;
                o_symbol <= r_symbol_1;
            else
                o_symbol <= r_symbol_0;
            end if;
        end if;
    end process outputData;
end behavioral;