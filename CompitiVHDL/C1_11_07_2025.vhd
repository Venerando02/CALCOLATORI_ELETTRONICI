library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity C1_07_11_2025 is
Port
(
clk, start: in std_logic;  
op: in std_logic;  
conta: in integer range 0 to 2; 
stato: out integer  range 0 to 5
); 
end C1_07_11_2025;

architecture Beh of C1_07_11_2025 is
signal st: integer range 0 to 5;
begin
     stato <= st;
     process(clk)
     begin
          if clk'event and clk = '1' then
          case st is
               when 0 => if start <= '1' then st <= 1;
                         else st <= 0;
                         end if;
               when 1 => if op <= '1' then st <= 3;
                         else st <= 2;
                         end if;
               when 2 => st <= 4;
               when 3 => if conta = 2 then st <= 4;
                         else if conta < 2 then st <= 3;
                         end if;
                         end if;
               when 4 => st <= 5;
               when 5 => st <= 0;
           end case;
          end if;
     end process;
end Beh;
