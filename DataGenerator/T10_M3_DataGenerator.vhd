--Team 10 - 762102 872403
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity T10_M3_DataGenerator is
    port
    (
        i_Clk       : in std_logic;
        i_Reset     : in std_logic;
        i_CE1       : in std_logic;
        i_mode      : in std_logic_vector(3 downto 0);
        i_start     : in std_logic;
        i_resend    : in std_logic; -- Resend signal from CRC. Active High
        o_data      : out std_logic_vector(3 downto 0)
    );
end T10_M3_DataGenerator;

architecture behavioral of T10_M3_DataGenerator is
    signal w_fixed          : std_logic_vector(3 downto 0);
    signal w_count          : std_logic_vector(3 downto 0);
    signal w_rand           : std_logic_vector(3 downto 0);
    signal w_student        : std_logic_vector(3 downto 0);
    signal w_temp           : std_logic_vector(3 downto 0);
    signal w_CE1            : std_logic;
    signal r_CE1_active     : std_logic;


begin
    resend: process(i_Clk)
    begin
        if (rising_edge(i_Clk)) then
            if (i_CE1 = '1') then
                r_CE1_active <= '1';
            else
                r_CE1_active <= '0';
            end if;
        end if;
    end process resend;

    holdCE: process(i_Clk)
    begin
        if (falling_edge(i_Clk)) then
            if (i_resend = '0') then
                if (r_CE1_active = '1') then
                    w_CE1 <= '1';
                else
                    w_CE1 <= '0';
                end if;
            else
                w_CE1 <= '0';
            end if;
        end if;
    end process holdCE;

    fixed: entity work.T10_M3_DG_fixed(behavioral)
        port map
        (
            i_sysClock => i_Clk,
            i_CE1Hz => w_CE1,
            i_mode => i_mode,
            o_BCDOut2 => w_fixed
        );

    count: entity work.T10_M3_DG_Count(behavioral)
        port map
        (
            i_start => i_start,
            i_Clk => i_Clk,
            i_Reset => i_Reset,
            i_CE => w_CE1,
            i_mode => i_mode,
            o_data => w_count
        );
    
    rand: entity work.T10_M3_DG_Random(behavioral)
        port map
        (
            i_CE => w_CE1,
            o_data => w_rand
        );

    temp: entity work.T10_M3_DG_Temp(behavioral)
        port map
        (
            o_data => w_temp
        );
        
    student: entity work.T10_M3_DG_student(behavioral)
        port map
        (
            i_sysClock => i_Clk,
            i_CE1Hz => w_CE1,
            i_mode => i_mode,
            o_BCDOut2 => w_student
        );
    
    multiplex: entity work.T10_M3_DG_DataMultiplexer(behavioral)
        port map
        (
            i_clk => i_clk,
            i_count => w_count,
            i_temp => w_temp,
            i_rand => w_rand,
            i_student => w_student,
            i_fixed => w_fixed,
            i_mode => i_mode,
            i_start => i_start,
            o_data => o_data
        );

    
end behavioral;