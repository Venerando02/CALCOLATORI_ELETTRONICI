library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity C1_09_09_2024 is
port
( 
op: in std_logic; 
stato: in std_logic_vector(1 downto 0); 
Read, En0, En1, Wr0, Wr1, Ready: out std_logic
);
end C1_09_09_2024;

architecture Beh of C1_09_09_2024 is
begin
     process(stato, op)
     begin
          case stato is 
               when "00" => if op = '0' or op = '1' then Read <= '0'; En0 <= '0'; En1 <= '0'; Wr0 <= '0'; Wr1 <= '0'; Ready <= '1';
                            end if;
               when "01" => if op = '0' or op = '1' then Read <= '1'; En0 <= '0'; En1 <= '0'; Wr0 <= '0'; Wr1 <= '0'; Ready <= '0';
                            end if;
               when "10" => if op = '0' or op = '1' then Read <= '1'; En0 <= '1'; En1 <= '1'; Wr0 <= '0'; Wr1 <= '0'; Ready <= '0';
                            end if;
               when "11" => if op = '0' then Read <= '0'; En0 <= '0'; En1 <= '0'; Wr0 <= '1'; Wr1 <= '0'; Ready <= '0';
                            else Read <= '0'; En0 <= '0'; En1 <= '0'; Wr0 <= '0'; Wr1 <= '1'; Ready <= '0';
                            end if;                          
          end case;
     end process;
end Beh;
