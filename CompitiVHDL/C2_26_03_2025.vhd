library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;

entity C2_26_03_2025 is
Port
(
clk, Op0,Op1,sel: in std_logic;  
WeA, WeB, WeR: in std_logic;  
Di: in std_logic_vector(15 downto 0); 
R: out std_logic_vector(15 downto 0) 
);
end C2_26_03_2025;

architecture Beh of C2_26_03_2025 is
signal A, B, AluRis0, AluRis1, Risultato: std_logic_vector(15 downto 0);
begin
     R <= AluRis0 when sel = '0' else
          AluRis1;
     AluRis0 <= A + B when Op0 = '0' else
                A - B;
     AluRis1 <= Di OR B when Op1 = '0' else
                Di AND B;
     Risultato <= AluRis0 when sel = '0' else
                  AluRis1;
     process(clk)
     begin
          if clk'event and clk = '0' then
                 if WeA = '1' then A <= Di;
                 end if;
                 if WeB = '1' then B <= Di;
                 end if;
                 if WeR = '1' then R <= Risultato;
                 end if;    
          end if;
     end process;
end Beh;
