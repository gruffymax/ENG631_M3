-- Team 10 - 762102 872403
-- Version 1
-- Tested on :-
--  Simulation  - Yes
--  Hardware    - Yes

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity T10_M3_DG_Count is
    port 
    (
        i_Clk   : in std_logic;
        i_CE    : in std_logic;
        i_start : in std_logic;
        i_Reset : in std_logic;
        i_mode  : in std_logic_vector(3 downto 0);
        o_data  : out std_logic_vector(3 downto 0)
    );
end entity T10_M3_DG_Count;

architecture behavioral of T10_M3_DG_Count is
    signal r_count : unsigned( 3 downto 0) := "0000";
begin
    count: process(i_Clk, i_Reset) 
    begin
        if (i_Reset = '1') then
            r_count <= "0000";
        elsif (rising_edge(i_Clk)) then
            if (i_CE = '1') then
                if (i_mode = "0100" and i_start = '1') then
                    r_count <= r_count + 1; --Unsigned will roll over to 0000.
                else
                    r_count <= "0000"; --Reset to 0 if mode not selected
                end if;
            end if;
             
                
        end if;
    end process count;

    outputData: process(i_Clk)
    begin
        if(falling_edge(i_Clk) and i_Reset = '0') then
            o_data <= std_logic_vector(r_count);
        end if;
    end process outputData;
end behavioral;
