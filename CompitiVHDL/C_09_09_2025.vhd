library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity C_09_09_2025 is
Port
(
op: in std_logic; 
stato: in std_logic_vector(1 downto 0); 
Rd, E0, E1, W0, W1, Ready: out std_logic
);
end C_09_09_2025;

architecture Beh of C_09_09_2025 is
signal st: std_logic_vector(1 downto 0);
begin
     st <= stato;
     process(stato)
     begin
          case stato is
          when "00" => if op = '0' then Rd <= '0'; E0 <= '0'; E1 <= '0'; W0 <= '0'; W1 <= '0'; Ready <= '1';
                       else Rd <= '0'; E0 <= '0'; E1 <= '0'; W0 <= '0'; W1 <= '0'; Ready <= '1';
                       end if;
          when "01" => if op = '0' then Rd <= '1'; E0 <= '0'; E1 <= '1'; W0 <= '0'; W1 <= '0'; Ready <= '0';
                       else Rd <= '1'; E0 <= '0'; E1 <= '1'; W0 <= '0'; W1 <= '0'; Ready <= '0';
                       end if;
          when "10" => if op = '0' then Rd <= '1'; E0 <= '1'; E1 <= '0'; W0 <= '0'; W1 <= '0'; Ready <= '0';
                       else Rd <= '1'; E0 <= '1'; E1 <= '0'; W0 <= '0'; W1 <= '0'; Ready <= '0';
                       end if;
          when "11" => if op = '0' then Rd <= '1'; E0 <= '0'; E1 <= '0'; W0 <= '1'; W1 <= '0'; Ready <= '0';
                       else Rd <= '1'; E0 <= '0'; E1 <= '0'; W0 <= '0'; W1 <= '1'; Ready <= '0';
                       end if;
          end case;
     end process;
end Beh;
