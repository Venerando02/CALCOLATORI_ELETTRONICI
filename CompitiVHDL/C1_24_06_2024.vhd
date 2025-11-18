library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity C1_24_06_2024 is
port
(
clk, WeA, WeR, sel: in std_logic;  
op: in std_logic_vector(1 downto 0); 
Di: in std_logic_vector(7 downto 0); 
R: out std_logic_vector(7 downto 0)
);
end C1_24_06_2024;

architecture Beh of C1_24_06_2024 is
signal A, AluRis, Risultato: std_logic_vector(7 downto 0);
begin
     AluRis <= A + Di when op = "00" else
               A - Di when op = "01" else
               A OR Di when op = "10" else
               A AND Di;
               
     Risultato <= AluRis when sel = '1' else
                  Di;
                  
     process(clk)
     begin   
          if clk'event and clk = '0' then
                 if WeA = '1' then A <= Di;
                 end if;
                 if WeR = '1' then R <= Risultato;
                 end if;
          end if;
     end process;
end Beh;
