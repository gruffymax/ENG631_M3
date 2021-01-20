--Team 10 - 762102
--Version 1
-- Tested on :-
-- Simulation   - Yes
-- Hardware     - No

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.All;

entity T10_M3_ModulatorA is
    port
    (
        i_Clk       : in std_logic;
        i_CE16      : in std_logic;
        i_symbol    : in std_logic_vector(1 downto 0);
        i_Reset     : in std_logic;
        o_dataI     : out std_logic_vector(7 downto 0);
        o_dataQ     : out std_logic_vector(7 downto 0)
    );
end T10_M3_ModulatorA;

architecture behavioral of T10_M3_ModulatorA is
    signal r_symbol     : std_logic_vector(1 downto 0) := "00";
    signal r_count      : integer range 0 to 7 := 0;
    signal w_dataI      : std_logic_vector(7 downto 0) := x"00";
    signal w_dataQ      : std_logic_vector(7 downto 0) := x"00";
    type zero_waveform_t is array(0 to 7) of unsigned(7 downto 0);
    type one_waveform_t is array(0 to 7) of unsigned(7 downto 0);
    signal zero_waveform : zero_waveform_t := (x"80", x"A0", x"C0", x"A0", x"80", x"60", x"40", x"60");
    signal one_waveform : one_waveform_t   := (x"80", x"60", x"40", x"60", x"80", x"A0", x"C0", x"A0");

begin
    count: process(i_Clk, i_Reset)
    begin
        if (i_Reset = '1') then
            r_count <= 0;
        elsif (rising_edge(i_Clk)) then
            if (i_CE16 = '1') then
                if (r_count = 7) then
                    r_count <= 0;
                else
                    r_count <= r_count + 1;
                end if;
            end if;         
        end if;
    end process count;

    latchsymbol: process(i_CE16, i_Reset)
    begin
        if (i_Reset = '1') then
            --ToDo
        elsif (rising_edge(i_CE16)) then
            if(r_count = 0) then
                r_symbol <= i_symbol;
            end if;
        end if;
    end process latchsymbol;
                    
    dataI: process(i_Clk, i_Reset)
    begin
        if (i_Reset = '1') then
            --ToDo
        elsif (rising_edge(i_Clk)) then
            if (i_CE16 = '1') then
                case r_symbol(1) is
                    when '0' =>
                        w_dataI <= std_logic_vector(zero_waveform(r_count));
                    when '1' =>
                        w_dataI <= std_logic_vector(one_waveform(r_count));
                    when others =>
                        w_dataI <= std_logic_vector(zero_waveform(r_count));
                end case;
            end if;
        end if;
    end process dataI;

    dataQ: process(i_Clk, i_Reset)
    begin
        if (i_Reset = '1') then
            --ToDo
        elsif (rising_edge(i_Clk)) then
            if (i_CE16 = '1') then
                case r_symbol(0) is
                    when '0' =>
                        w_dataQ <= std_logic_vector(zero_waveform(r_count));
                    when '1' =>
                        w_dataQ <= std_logic_vector(one_waveform(r_count));
                    when others =>
                        w_dataQ <= std_logic_vector(zero_waveform(r_count));
                end case;
            end if;
        end if;
    end process dataQ;

    o_dataI <= w_dataI;
    o_dataQ <= w_dataQ;
end behavioral;