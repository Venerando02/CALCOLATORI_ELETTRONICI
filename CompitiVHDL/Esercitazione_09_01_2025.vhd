library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;

entity Esercitazione_09_01_2025 is
Port
(
clk, selR,op: in std_logic;  
WRA,WRB,WRR: in std_logic;  
Din: in std_logic_vector(7 downto 0); 
R: out std_logic_vector(7 downto 0)
); 
end Esercitazione_09_01_2025;

architecture Beh of Esercitazione_09_01_2025 is
signal A, B, AluRis, MuxRis: std_logic_vector(7 downto 0);
begin
     AluRis <= A + B when op = '0' else
               A - B;
     MuxRis <= A when selR = '0' else
               AluRis;
     process(clk)
     begin
          if clk'event and clk = '0' then
                 if WRA = '1' then A <= Din;
                 end if;
                 if WRB = '1' then B <= Din;
                 end if;
                 if WRR = '1' then R <= MuxRis;
                 end if;
          end if;       
     end process;            
end Beh;
