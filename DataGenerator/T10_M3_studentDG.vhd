library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity T10_M3_studentDG is
    Port ( i_sysClock   : in STD_LOGIC;
           i_CE1Hz      : in STD_LOGIC;
           i_mode       : in STD_LOGIC_VECTOR (3 downto 0);
           o_BCDOut2    : out STD_LOGIC_VECTOR (3 downto 0));
end T10_M3_studentDG;

architecture archStudentDG of T10_M3_studentDG is
    
    type t_studentNum is array (5 downto 0) of STD_LOGIC_VECTOR(3 downto 0);
    
    signal r_student1   : t_studentNum := ("0010","0000","0001","0010","0110","0111"); -- 762102                                        
    signal r_student2   : t_studentNum := ("0011","0000","0100","0010","0111","1000"); -- 872403
    signal r_BCDout2    : STD_LOGIC_VECTOR(3 downto 0);
    signal r_counter    : INTEGER range 0 to 5 := 0 ;
    signal r_start      : STD_LOGIC_VECTOR(1 downto 0) := "00"; -- 00 is off, 01 is student 1, 10 is student 2, if 11 is seen, clear to 00 and reset
begin
    
    studentProc : process (i_sysClock, i_CE1Hz, i_mode)
    begin
    
        if rising_edge(i_sysClock) then
            if i_CE1HZ = '1' then
            
                case i_mode is
                    when "0110" =>  -- student number 1
                        if r_start /= "01" then
                            r_counter <= 0;
                            r_start <= "01";
                        end if;
                        if r_start = "01" then
                        r_BCDOut2 <= r_student1(r_counter);
                        r_counter <= r_counter + 1;
                        end if;
                                                
                    when "0111" =>  -- student number 2
                        if r_start /= "10" then
                            r_counter <= 0;
                            r_start <= "10";
                        end if;
                        if r_start = "10" then
                        r_BCDOut2 <= r_student2(r_counter);
                        end if;
                        
                    when others =>
                        r_BCDOut2 <= "0000";
                        r_start <= "00";        
                end case;
                if r_counter >= 5 then   --rolls over counter back to 0
                    r_counter <= 0;
                else
                    r_counter <= r_counter + 1;
                end if;
                
                
            end if;
        end if;
    end process studentProc;
    
    o_BCDOut2 <= r_BCDOut2;

end archStudentDG;
