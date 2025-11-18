library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Esercitazione1 is
Port(clk, start: in std_logic;  
 Op,ready: in std_logic;  
 conta: in integer range 0 to 2;  
 stato: out integer range 0 to 4 ); 
end Esercitazione1;

architecture Beh of Esercitazione1 is
signal st: integer range 0 to 4;
begin
     stato <= st;
     process(clk)
     begin
          if clk'event and clk = '0' then
          case st is 
          when 0 => if start <= '1' then st <= 1;
                      else st <= 0;
                      end if;
          when 1 => if Op <= '0' then st <= 2;
                      else st <= 3;
                      end if;
          when 2 => st <= 4;
          when 3 => if conta = 2 then st <= 0;
                      else if conta < 2 then st <= 3;
                      end if;
                      end if;
          when 4 => if ready = '1' then st <= 0;
                      else st <= 4;
                      end if;
          end case;
          end if;
    end process;     
end Beh;
