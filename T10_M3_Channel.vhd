--Team 10 - 762102
--Version 0
-- Tested on :-
-- Simulation   - No
-- Hardware     - No

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.All;

entity T10_M3_Channel is
    port
    (
        i_clk       : in std_logic;
        i_CE        : in std_logic;
        i_Itx       : in std_logic_vector(7 downto 0);
        i_Qtx       : in std_logic_vector(7 downto 0);
        i_prn       : in std_logic_vector(7 downto 0);
        i_mode_sw0  : in std_logic;
        i_mode_sw1  : in std_logic;
        o_Irx       : out std_logic_vector(7 downto 0);
        o_Qrx       : out std_logic_vector(7 downto 0)
    );
end T10_M3_Channel;

architecture behavioral of T10_M3_Channel is
    signal r_random_16  : unsigned(3 downto 0);
    signal r_random_32  : unsigned(4 downto 0);
    signal r_random_64  : unsigned(5 downto 0);
    signal w_Irx        : unsigned(7 downto 0) := x"00";
    signal w_Qrx        : unsigned(7 downto 0) := x"00";
    signal r_Itx_temp   : unsigned(7 downto 0) := x"00";
    signal r_Qtx_temp   : unsigned(7 downto 0) := x"00";    
    signal w_sw0        : std_logic;
    signal w_sw1        : std_logic;
    signal r_mode       : std_logic_vector(1 downto 0);
begin
    latch: process(i_CE)
    begin
        if (rising_edge(i_CE)) then
            --Latch +- 16 value
            r_random_16(3) <= i_prn(3);
            r_random_16(2) <= i_prn(2);
            r_random_16(1) <= i_prn(1);
            r_random_16(0) <= i_prn(0);
            --Latch +- 32 value
            r_random_32(4) <= i_prn(4);
            r_random_32(3) <= i_prn(3);
            r_random_32(2) <= i_prn(2);
            r_random_32(1) <= i_prn(1);
            r_random_32(0) <= i_prn(0);
            --Latch +- 64 value
            r_random_64(5) <= i_prn(5);
            r_random_64(4) <= i_prn(4);
            r_random_64(3) <= i_prn(3);
            r_random_64(2) <= i_prn(2);
            r_random_64(1) <= i_prn(1);
            r_random_64(0) <= i_prn(0);
            --Latch mode
            r_mode(0) <= w_sw0;
            r_mode(1) <= w_sw1;
        end if;
    end process latch;

    noise: process(i_clk)
    begin
        if (rising_edge(i_clk)) then
            if (i_CE = '1') then
                case r_mode is
                    when "00" =>
                        w_Irx <= unsigned(i_Itx); --No noise added
                        w_Qrx <= unsigned(i_Qtx); 
                    when "01" =>
                        if (i_prn(4) = '1') then
                            w_Irx <= unsigned(i_Itx) - resize(r_random_16, 8);
                            w_Qrx <= unsigned(i_Qtx) - resize(r_random_16, 8);
                        else
                            w_Irx <= unsigned(i_Itx) + resize(r_random_16, 8);
                            w_Qrx <= unsigned(i_Qtx) + resize(r_random_16, 8);
                        end if;
                    when "10" =>
                        if (i_prn(5) = '1') then
                            w_Irx <= unsigned(i_Itx) - resize(r_random_32, 8);
                            w_Qrx <= unsigned(i_Qtx) - resize(r_random_32, 8);
                        else
                            w_Irx <= unsigned(i_Itx) + resize(r_random_32, 8);
                            w_Qrx <= unsigned(i_Qtx) + resize(r_random_32, 8);
                        end if;
                    when "11" =>
                        if (i_prn(6) = '1') then
                            w_Irx <= unsigned(i_Itx) - resize(r_random_64, 8);
                            w_Qrx <= unsigned(i_Qtx) - resize(r_random_64, 8);
                        else
                            w_Irx <= unsigned(i_Itx) + resize(r_random_64, 8);
                            w_Qrx <= unsigned(i_Qtx) + resize(r_random_64, 8);
                        end if;
                    when others =>
                        w_Irx <= unsigned(i_Itx); --No noise added
                        w_Qrx <= unsigned(i_Qtx); 
                end case;
            end if;
        end if;
    end process noise;

    db0: entity work.T10_M3_Debounce(behavioral)
        port map
        (
            i_Clk => i_clk,
            i_input => i_mode_sw0,
            o_output => w_sw0
        );
    
    db1: entity work.T10_M3_Debounce(behavioral)
        port map
        (
            i_Clk => i_clk,
            i_input => i_mode_sw1,
            o_output => w_sw1
        );      

    o_Irx <= std_logic_vector(w_Irx);
    o_Qrx <= std_logic_vector(w_Qrx);
end behavioral; 