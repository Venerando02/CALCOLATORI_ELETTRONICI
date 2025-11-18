library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity C1_14_03_2023 is
Port
(
clk, start: in std_logic;  
Op,ready: in std_logic;  
stato: out integer range 0 to 5 
); 
end C1_14_03_2023;

architecture Beh of C1_14_03_2023 is
signal st : integer range 0 to 5;
begin
     stato <= st;
     process(clk)
     begin
          if clk'event and clk = '0' then
              case st is
                   when 0 => if start = '1' then st <= 1;
                             else st <= 0;
                             end if;
                   when 1 => st <= 2;
                   when 2 => if ready = '0' then st <= 2;
                             else if Op = '0' then st <= 3;
                             else st <= 4;
                             end if;
                             end if;
                   when 3 => st <= 0;
                   when 4 => st <= 5;
                   when 5 => st <= 0;
              end case;
          end if;
     end process;
end Beh;

