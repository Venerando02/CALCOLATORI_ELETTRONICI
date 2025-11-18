library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;

entity C2_22_01_2025 is
Port
(
clk, WeA, WeB, WeC: in std_logic;  
Din: in std_logic_vector(7 downto 0); 
op:   in std_logic_vector(1 downto 0); 
R:  out std_logic_vector(7 downto 0) 
); 
end C2_22_01_2025;

architecture Beh of C2_22_01_2025 is
signal A, B, C, AluRis: std_logic_vector(7 downto 0);
begin
     AluRis <= A + B when op = "00" else
               A + C when op = "01" else
               A OR B when op = "10" else
               A AND C;
     process(clk)
     begin
          if clk'event and clk = '0' then
                 if WeA = '1' then A <= Din;
                 end if;
                 if WeB = '1' then B <= Din;
                 end if;
                 if WeC = '1' then C <= AluRis;
                 end if;
          end if;
     end process;
end Beh;
