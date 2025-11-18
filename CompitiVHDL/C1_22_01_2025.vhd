library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity C1_22_01_2025 is
Port
(
clk: in std_logic;  
avvio, en, op: in std_logic;  
conta: in integer range 0 to 3; 
stato: out integer range 0 to 4
); 
end C1_22_01_2025;

architecture Beh of C1_22_01_2025 is
signal st: integer range 0 to 4;
begin
     stato <= st;
     process(clk)
     begin
          if clk'event and clk = '1' then
          case st is
               when 0 => if avvio <= '1' then st <= 1;
                         else st <= 0;
                         end if;
               when 1 => if en = '1' and op = '0' then st <= 2;
                         else if en = '1' and op = '1' then st <= 3;
                         else st <= 0;
                         end if;
                         end if;
               when 2 => st <= 4;
               when 3 => if conta = 3 then st <= 4;
                         else st <= 3;
                         end if; 
               when 4 => st <= 0;
     end case;
     end if;
     end process;
end Beh;
