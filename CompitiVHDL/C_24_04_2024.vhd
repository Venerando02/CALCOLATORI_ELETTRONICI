library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity C_24_04_2024 is
Port
(
op: in std_logic; 
stato: in std_logic_vector(1 downto 0); 
EXEA, EXEB, WRA, WRB, Ready: out std_logic
);
end C_24_04_2024;

architecture Beh of C_24_04_2024 is
begin
     process(stato)
     begin
          case stato is
               when "00" => if op = '1' then EXEA <= '0'; EXEB <= '0'; WRA <= '0'; WRB <= '0'; Ready <= '1';
                            else EXEA <= '0'; EXEB <= '0'; WRA <= '0'; WRB <= '0'; Ready <= '1';
                            end if;
               when "01" => if op = '1' then EXEA <= '0'; EXEB <= '1'; WRA <= '0'; WRB <= '0'; Ready <= '0';
                            else EXEA <= '1'; EXEB <= '0'; WRA <= '0'; WRB <= '0'; Ready <= '0';
                            end if;
               when "10" => if op = '1' then EXEA <= '0'; EXEB <= '1'; WRA <= '0'; WRB <= '0'; Ready <= '0';
                            else EXEA <= '1'; EXEB <= '0'; WRA <= '0'; WRB <= '0'; Ready <= '0';
                            end if;
               when "11" => if op = '1' then EXEA <= '0'; EXEB <= '0'; WRA <= '0'; WRB <= '1'; Ready <= '0';
                            else EXEA <= '0'; EXEB <= '0'; WRA <= '1'; WRB <= '0'; Ready <= '0';
                            end if;             
          end case;
     end process;
end Beh;
