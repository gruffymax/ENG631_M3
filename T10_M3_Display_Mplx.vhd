-- Team 10 - 762102 872403
--Version 1
-- Tested on :-
--  Simulation  - No
--  Hardware    - No

library IEEE;
use IEEE.std_logic_1164.all;

entity T10_M3_Display_Mplx is
    port
    (
        i_clk       : in std_logic;
        i_select    : in std_logic_vector(2 downto 0);
        i_DG_Mode   : in std_logic_vector(3 downto 0);
        i_DG_Data   : in std_logic_vector(3 downto 0);
        i_Dmod_DataA : in std_logic_vector(3 downto 0);
        i_Dmod_DataB : in std_logic_vector(3 downto 0);
        i_SC_Symbol : in std_logic_vector(1 downto 0);
        i_ItxA       : in std_logic_vector(7 downto 0);
        i_QtxA       : in std_logic_vector(7 downto 0);
        i_IrxA       : in std_logic_vector(7 downto 0);
        i_QrxA       : in std_logic_vector(7 downto 0);
        i_ItxB       : in std_logic_vector(7 downto 0);
        i_QtxB       : in std_logic_vector(7 downto 0);
        i_IrxB       : in std_logic_vector(7 downto 0);
        i_QrxB       : in std_logic_vector(7 downto 0);
        o_D3        : out std_logic_vector(3 downto 0);
        o_D2        : out std_logic_vector(3 downto 0);
        o_D1        : out std_logic_vector(3 downto 0);
        o_D0        : out std_logic_vector(3 downto 0)        
    );
end T10_M3_Display_Mplx;

architecture behavioral of T10_M3_Display_Mplx is
    signal w_D3    : std_logic_vector(3 downto 0) := x"0";
    signal w_D2    : std_logic_vector(3 downto 0) := x"0";
    signal w_D1    : std_logic_vector(3 downto 0) := x"0";
    signal w_D0    : std_logic_vector(3 downto 0) := x"0";
begin
    mplx: process(i_clk)
    begin
        if (rising_edge(i_clk)) then
            case i_select is
                -- Normal M2 Display
                when "000"  =>
                    w_D3 <= i_DG_Mode;
                    w_D2 <= i_DG_Data;
                    w_D1(3 downto 1) <= "000";
                    w_D1(0) <= i_SC_Symbol(1);
                    w_D0(3 downto 1) <= "000";
                    w_D0(0) <= i_SC_Symbol(0);

                when "100"  =>
                    w_D3 <= i_DG_Mode;
                    w_D2 <= i_DG_Data;
                    w_D1(3 downto 1) <= "000";
                    w_D1(0) <= i_SC_Symbol(1);
                    w_D0(3 downto 1) <= "000";
                    w_D0(0) <= i_SC_Symbol(0);
                
                -- Scheme A
                when "001" =>
                    w_D3 <= i_ItxA(7 downto 4);
                    w_D2 <= i_ItxA(3 downto 0);
                    w_D1 <= i_QtxA(7 downto 4);
                    w_D0 <= i_QtxA(3 downto 0);

                when "010" =>
                    w_D3 <= "0000";
                    w_D2 <= i_DG_Data;
                    w_D1 <= "0000";
                    w_D0 <= i_Dmod_DataA;

                when "011" =>
                    w_D3 <= i_IrxA(7 downto 4);
                    w_D2 <= i_IrxA(3 downto 0);
                    w_D1 <= i_QrxA(7 downto 4);
                    w_D0 <= i_QrxA(3 downto 0);

                -- Scheme B
                when "101" =>
                    w_D3 <= i_ItxB(7 downto 4);
                    w_D2 <= i_ItxB(3 downto 0);
                    w_D1 <= i_QtxB(7 downto 4);
                    w_D0 <= i_QtxB(3 downto 0);

                when "110" => 
                    w_D3 <= "0000";
                    w_D2 <= i_DG_Data;
                    w_D1 <= "0000";
                    w_D0 <= i_Dmod_DataB;

                when "111" =>
                    w_D3 <= i_IrxB(7 downto 4);
                    w_D2 <= i_IrxB(3 downto 0);
                    w_D1 <= i_QrxB(7 downto 4);
                    w_D0 <= i_QrxB(3 downto 0);

                when others => 
                    w_D3 <= "0000";
                    w_D2 <= "0000";
                    w_D1 <= "0000";
                    w_D0 <= "0000";
            end case;
        end if;
    end process mplx;

    o_D3 <= w_D3;
    o_D2 <= w_D2;
    o_D1 <= w_D1;
    o_D0 <= w_D0;
end behavioral;