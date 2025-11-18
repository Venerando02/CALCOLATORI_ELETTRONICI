library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity C1_24_09_2024 is
Port
(
clk : in std_logic;  
ready, cond, x: in std_logic;  
C: in integer range 0 to 1; 
stato: out integer range 0 to 5
);
end C1_24_09_2024;

architecture Beh of C1_24_09_2024 is
signal st: integer range 0 to 5;
begin
     stato <= st;
     process(clk)
     begin
          if clk'event and clk = '0' then
          case st is
               when 0 => if ready = '1' then st <= 1;
                         else st <= 0;
                         end if;
               when 1 => if cond = '0' then st <= 2;
                         else st <= 3;
                         end if;
               when 2 => if x = '0' then st <= 3;
                         else st <= 4;
                         end if;
               when 3 => st <= 0;
               when 4 => if C = 1 then st <= 0;
                         else st <= 4;
                         end if;
          end case;
          end if;     
     end process;
end Beh;
