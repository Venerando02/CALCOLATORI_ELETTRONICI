library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity C1_27_09_2023 is
Port
(
op: in std_logic; 
stato: in std_logic_vector(1 downto 0); 
ReadA, ReadB, Exe1, Exe2, Write: out std_logic
);
end C1_27_09_2023;

architecture Beh of C1_27_09_2023 is
begin
     process(op, stato)
     begin
          case stato is 
               when "00" => if op = '0' or op = '1' then ReadA <= '0';  ReadB <= '0';  Exe1 <= '0';  Exe2 <= '0'; Write <= '0';
                            end if;
               when "01" => if op = '0' then ReadA <= '0';  ReadB <= '1';  Exe1 <= '0';  Exe2 <= '0'; Write <= '0';
                            else ReadA <= '1';  ReadB <= '0';  Exe1 <= '0';  Exe2 <= '0'; Write <= '0';
                            end if;
               when "10" => if op = '0' then ReadA <= '0';  ReadB <= '0';  Exe1 <= '1';  Exe2 <= '0'; Write <= '1';
                            else ReadA <= '0';  ReadB <= '0';  Exe1 <= '0';  Exe2 <= '1'; Write <= '0';
                            end if;
               when "11" => if op = '0' then ReadA <= '0';  ReadB <= '0';  Exe1 <= '0';  Exe2 <= '0'; Write <= '0';
                            else ReadA <= '0';  ReadB <= '0';  Exe1 <= '0';  Exe2 <= '1'; Write <= '1';
                            end if;
          end case;
     end process;
end Beh;
