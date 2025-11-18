library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;

entity C2_14032023 is
Port
(
clk,sel, OP: in std_logic;  
WA,WR: in std_logic;  
I: in std_logic_vector(15 downto 0); 
R: out std_logic_vector(15 downto 0)
); 
end C2_14032023;

architecture Beh of C2_14032023 is
signal A, AluRis, B: std_logic_vector(15 downto 0);
begin
     AluRis <= A + B when OP = '0' else
               A AND B when OP = '1';
     process(clk)
     begin
          if clk'event and clk = '0' 
          then
              if WA = '1' then A <= I;
              end if;
              if WR = '1' then R <= AluRis;
              end if;
          end if;
     end process;
end Beh;
