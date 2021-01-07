-- Team 10 - 762102 872403
-- Version 1.0
-- Tested on :-
-- Simulation   - Yes
-- Hardware     - Yes

library IEEE;
use IEEE.std_logic_1164.all;

entity T10_M3_DG_Student is
    port
    (
        i_Clk   : in std_logic;
        i_CE    : in std_logic; --1 Hz CE
        i_mode  : in std_logic_vector;
        o_data  : out std_logic_vector;
        i_Reset : in std_logic
    );
end T10_M3_DG_Student;

architecture behavioral of T10_M3_DG_Student is
    signal r_pos : natural;
    signal r_prevMode : std_logic_vector(3 downto 0);
    signal r_output : std_logic_vector(3 downto 0);
begin
    studentCount: process(i_Clk, i_Reset) is
    begin
        if (i_Reset = '1') then
            r_pos <= 0;
        elsif (rising_edge(i_Clk)) then
            if (r_pos = 5) then
                r_pos <= 0;
            else
                r_pos <= r_pos + 1;
            end if;
        end if;
    end process studentCount;

    studentOutput: process(i_Clk) is
    begin
        if (falling_edge(i_Clk) and i_Reset = '0') then
            if (i_mode = "0110") then
                case r_pos is
                    when 0 => r_output <= "0111"; --7
                    when 1 => r_output <= "0110"; --6
                    when 2 => r_output <= "0010"; --2
                    when 3 => r_output <= "0001"; --1
                    when 4 => r_output <= "0000"; --0
                    when 5 => r_output <= "0010"; --2
                    when others => r_output <= "0000";
                end case;
            elsif (i_mode = "0111") then
                case r_pos is
                    when 0 => r_output <= "1000"; --8
                    when 1 => r_output <= "0111"; --7
                    when 2 => r_output <= "0010"; --2
                    when 3 => r_output <= "0100"; --4
                    when 4 => r_output <= "0000"; --0
                    when 5 => r_output <= "0011"; --3
                    when others => r_output <= "0000";
                end case;
            end if;
        end if;
    end process studentOutput;
    o_data <= r_output;
end behavioral;