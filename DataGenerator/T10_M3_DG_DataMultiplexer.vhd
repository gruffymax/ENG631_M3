-- Team 10 - 762102 872403
-- Version 1.0
-- Tested on :-
--  Simulation  - Yes
--  Hardware    - Yes

library IEEE;
use IEEE.std_logic_1164.all;

entity T10_M3_DG_DataMultiplexer is
    port
    (
        i_Clk       : in std_logic;
        i_count     : in std_logic_vector(3 downto 0);
        i_temp      : in std_logic_vector(3 downto 0);
        i_rand      : in std_logic_vector(3 downto 0);
        i_student   : in std_logic_vector(3 downto 0);
        i_fixed     : in std_logic_vector(3 downto 0);
        i_mode      : in std_logic_vector(3 downto 0);
        i_start     : in std_logic;
        o_data      : out std_logic_vector(3 downto 0)
    );
end T10_M3_DG_DataMultiplexer;

architecture behavioral of T10_M3_DG_DataMultiplexer is
    signal r_data : std_logic_vector(3 downto 0);
begin
    data: process(i_Clk) is
    begin
        if (rising_edge(i_clk)) then
            if (i_start = '0') then
                r_data <= "0000";
            else
                case i_mode is
                    when "0000" =>
                        r_data <= i_fixed;
                    when "0001" =>
                        r_data <= i_fixed;
                    when "0010" =>
                        r_data <= i_fixed;
                    when "0011" =>
                        r_data <= i_fixed;
                    when "0100" =>
                        r_data <= i_count;
                    when "0101" =>
                        r_data <= i_rand;
                    when "0110" =>
                        r_data <= i_student;
                    when "0111" => 
                        r_data <= i_student;
                    when others =>
                        r_data <= i_temp;
                end case;                               
            end if;
        end if;
    end process data;
    
    dataout: process(i_Clk) is
    begin
        if (falling_edge(i_Clk)) then
            o_data <= r_data;
        end if;
    end process dataout;
end behavioral;