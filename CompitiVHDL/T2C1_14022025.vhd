library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity T2C1_14022025 is
Port(
clk, avvio: in std_logic;  
op: in std_logic_vector(1 downto 0);  
conta: in integer range 0 to 2; 
stato: out integer range 0 to 5
);
end T2C1_14022025;

architecture Beh of T2C1_14022025 is
signal st: integer range 0 to 5;
begin
     stato <= st;
     process(clk)
     begin
          if clk'event and clk = '1' then
          case st is
               when 0 => if avvio = '1' then st <= 1;
                                        else st <= 0;
                                        end if;
               when 1 => if op <= "10" then st <= 2;
                         else if op <= "11" then st <= 3;
                         else if op <= "0-" then st <= 4;
                                                  end if;
                                                  end if;
                                                  end if;
               when 2 => st <= 5;
               when 3 => if conta = 1 then st <= 5;
                                      else st <= 3;
                                      end if;
               when 4 => st <= 0;
               when 5 => st <= 0;                                    
         end case;
         end if;
    end process;
end Beh;
