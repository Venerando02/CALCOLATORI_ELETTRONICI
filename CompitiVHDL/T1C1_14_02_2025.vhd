library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;

entity T1C1_14_02_2025 is
Port
(
clk, WeA,WeR: in std_logic;  
Din: in std_logic_vector(7 downto 0); 
op:   in std_logic_vector(1 downto 0); 
conta: in integer range 0 to 3; 
R:  out std_logic_vector(7 downto 0)
); 
end T1C1_14_02_2025;

architecture Beh of T1C1_14_02_2025 is
signal A, AluRis: std_logic_vector(7 downto 0);
signal Completed: std_logic;
begin
     AluRis <= A + Din when op = "00" else
               A - Din when op = "01" else
               A OR Din when op = "10" else
               A AND Din;
     Completed <= '0' when op(1) = '0' and conta < 3 else
                  '1';
     process(clk)
     begin
          if clk'event and clk = '0' then
                       if WeA = '1' then A <= Din;
                       end if;
                       if WeR = '1' and Completed = '1' then R <= AluRis;
                       end if;
          end if;            
     end process;
end Beh;
