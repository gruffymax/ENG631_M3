-- Team 10 - 762102 872403
-- Version 1
-- Tested on :-
--  Simulation - Yes
--  Hardware   - Yes

library IEEE;
use IEEE.std_logic_1164.all;

entity T10_M3_Debounce is
    port
    (
        i_Clk    : in std_logic;
        i_input  : in std_logic;
        o_output : out std_logic
    );
end T10_M3_Debounce;

architecture behavioral of T10_M3_Debounce is
    signal r_output_db : std_logic := '0';
    --Counter for 20ms debounce delay. System clock = 100 MHz
    signal r_count : std_logic := '0';
    signal r_counter : integer range 0 to 2000000; 
    signal r_prev_input     : std_logic := '0';

begin
    debounce: process(i_Clk)
    begin
        if (rising_edge(i_Clk)) then
            if (i_input /= r_prev_input) then
                r_count <= '1'; -- Transition change detected. Start the timer
            end if;
            
            if (r_count = '1') then
                if (r_counter = 2000000) then
                    --Timer complete. Output current switch state
                    r_counter <= 0;
                    r_count <= '0';
                    r_output_db <= i_input;
                else
                    --Increment counter
                    r_counter <= r_counter + 1;
                end if;
            end if;
            r_prev_input <= i_input;
        end if;        
    end process debounce;
    
    o_output <= r_output_db;
end behavioral;