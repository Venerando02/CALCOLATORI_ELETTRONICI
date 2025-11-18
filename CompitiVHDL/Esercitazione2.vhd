library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;

entity Esercitazione2 is
Port
(
clk, selA,op: in std_logic;  
WRA,WRB: in std_logic;  
Din: in std_logic_vector(7 downto 0); 
R: out std_logic_vector(7 downto 0)
 ); 
end Esercitazione2;

architecture Beh of Esercitazione2 is
signal AluRis, A, B: std_logic_vector(7 downto 0);
begin
     AluRis <= A + B when op = '0' else
               A - B;
     R <= AluRis;
     process(clk)
     begin
          if clk'event and clk = '0' then
                 if WRA = '1' then if selA <= '1' then A <= Din;
                              else  A <= AluRis;
                              end if;
                 end if;
                 if WRB = '1' then B <= Din;
                 end if;
     end if;
     end process;
end Beh;
