library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity C1_16_06_2025 is
port
(
op: in std_logic;
stato: in std_logic_vector(1 downto 0);
Sc0, Sc1, Sc2, Sc3, Sc4: out std_logic
);
end C1_16_06_2025;

architecture Beh of C1_16_06_2025 is
signal st: std_logic_vector(1 downto 0);
begin
     st <= stato;
     process(op, stato)
     begin
          case st is 
          when "00" => if op <= '1' then Sc0 <= '0'; Sc1 <= '1'; Sc2 <= '1'; Sc3 <= '1'; Sc4 <= '0';
                       else Sc0 <= '0'; Sc1 <= '0'; Sc2 <= '0'; Sc3 <= '1'; Sc4 <= '0';
                       end if;
          when "01" => if op <= '1' then Sc0 <= '1'; Sc1 <= '0'; Sc2 <= '1'; Sc3 <= '1'; Sc4 <= '0';
                       else Sc0 <= '1'; Sc1 <= '0'; Sc2 <= '0'; Sc3 <= '1'; Sc4 <= '0';
                       end if; 
          when "11" => if op <= '1' then Sc0 <= '0'; Sc1 <= '0'; Sc2 <= '1'; Sc3 <= '0'; Sc4 <= '1';
                       else Sc0 <= '0'; Sc1 <= '0'; Sc2 <= '0'; Sc3 <= '0'; Sc4 <= '0';
                       end if;
          when "10" =>  if op <= '1' then Sc0 <= '0'; Sc1 <= '0'; Sc2 <= '1'; Sc3 <= '0'; Sc4 <= '0';
                       else Sc0 <= '0'; Sc1 <= '1'; Sc2 <= '0'; Sc3 <= '0'; Sc4 <= '0';
                       end if;
          end case;
     end process;
end Beh;
