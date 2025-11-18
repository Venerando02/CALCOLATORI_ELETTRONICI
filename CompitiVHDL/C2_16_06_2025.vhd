library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity C2_16_06_2025 is
Port
(
op: in std_logic; 
stato: in std_logic_vector(1 downto 0); 
En0, En1, We0, We1, Sel: out std_logic
); 
end C2_16_06_2025;

architecture Beh of C2_16_06_2025 is
begin
     process(op, stato)
     begin
          case stato is
          when "00" => if op = '0' then En0 <= '0'; En1 <= '0'; We0 <= '0'; We1 <= '0'; Sel <= '0';
                       else En0 <= '0'; En1 <= '0'; We0 <= '1'; We1 <= '0'; Sel <= '0';
                       end if;
          when "01" => if op = '0' then En0 <= '1'; En1 <= '0'; We0 <= '0'; We1 <= '0'; Sel <= '1';
                       else En0 <= '1'; En1 <= '1'; We0 <= '1'; We1 <= '1'; Sel <= '1';
                       end if;
          when "10" => if op = '0' then En0 <= '0'; En1 <= '0'; We0 <= '0'; We1 <= '1'; Sel <= '1';
                       else En0 <= '0'; En1 <= '1'; We0 <= '1'; We1 <= '0'; Sel <= '1';
                       end if;
          when "11" => if op = '0' then En0 <= '0'; En1 <= '0'; We0 <= '0'; We1 <= '0'; Sel <= '0';
                       else En0 <= '0'; En1 <= '1'; We0 <= '1'; We1 <= '0'; Sel <= '0';
                       end if;
          end case;
     end process;
end Beh;
