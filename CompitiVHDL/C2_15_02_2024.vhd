library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity C2_15_02_2024 is
Port
(
clk,oper: in std_logic;  
WeA,WeB, WeR, sel: in std_logic;  
Din: in std_logic_vector(7 downto 0); 
R: out std_logic_vector(7 downto 0) 
); 
end C2_15_02_2024;

architecture Beh of C2_15_02_2024 is
signal risultato, A, B, D2: std_logic_vector(7 downto 0);
begin
     risultato <= A + D2 when oper = '0' else
                  A OR D2;
     D2 <= B when sel = '1' else Din;
     
     process(clk)
     begin
          if clk'event and clk = '0' then
                 if WeA = '1' then A <= Din;
                 end if;
                 if WeB = '1' then B <= Din;
                 end if;
                 if WeR = '1' then R <= risultato;
                 end if;
          end if;
     end process;
end Beh;
