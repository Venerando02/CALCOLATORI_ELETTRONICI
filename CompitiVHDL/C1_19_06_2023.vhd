library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity C1_19_06_2023 is
Port
(
clk, start: in std_logic;  
Op,ready: in std_logic;  
conta: in integer range 0 to 3;  
stato: out integer range 0 to 5 
);
end C1_19_06_2023;

architecture Beh of C1_19_06_2023 is
signal st: integer range 0 to 5;
begin
     stato <= st;
     process(clk)
     begin
       if clk'event and clk = '0' then
          case st is 
               when 0 => if start = '1' then st <= 1;
                         else st <= 0;
                         end if;
               when 1 => if op = '1' then st <= 3;
                         else st <= 2;
                         end if;
               when 2 => if ready = '0' then st <= 2;
                         else st <= 4;
                         end if;
               when 3 => if conta = 3 then st <= 5;
                         else if conta < 3 then st <= 3;
                         end if;
                         end if;
               when 4 => st <= 0;
               when 5 => st <= 0; 
          end case;
        end if;
     end process;
end Beh;
