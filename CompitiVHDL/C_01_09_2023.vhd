library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity C_01_09_2023 is
Port
(
code: in std_logic; 
state: in std_logic_vector(1 downto 0); 
ExeA, ExeB, WriteA,WriteB,WriteR: out std_logic
); 
end C_01_09_2023;

architecture Beh of C_01_09_2023 is
begin
     process(code, state)
     begin
          case state is 
                when "00" => if code = '0' then ExeA <= '0'; ExeB <= '0'; WriteA <= '1'; WriteB <= '0';WriteR <= '0';
                             else ExeA <= '0'; ExeB <= '0'; WriteA <= '0'; WriteB <= '1';WriteR <= '0';
                             end if;
                when "01" => if code = '0' then ExeA <= '1'; ExeB <= '0'; WriteA <= '0'; WriteB <= '0';WriteR <= '0';
                             else ExeA <= '0'; ExeB <= '1'; WriteA <= '0'; WriteB <= '0';WriteR <= '0';
                             end if;
                when "10" => if code = '0' then ExeA <= '0'; ExeB <= '0'; WriteA <= '0'; WriteB <= '0';WriteR <= '0';
                             else ExeA <= '0'; ExeB <= '1'; WriteA <= '0'; WriteB <= '0';WriteR <= '0';
                             end if;
                when "11" => if code = '0' then ExeA <= '0'; ExeB <= '0'; WriteA <= '0'; WriteB <= '0';WriteR <= '1';
                             else ExeA <= '0'; ExeB <= '0'; WriteA <= '0'; WriteB <= '0';WriteR <= '1';
                             end if;
           end case;
     end process;
end Beh;
