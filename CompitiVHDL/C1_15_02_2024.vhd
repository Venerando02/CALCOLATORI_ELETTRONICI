library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity C1_15_02_2024 is
Port
(
clk, Cond : in std_logic;  
X: in std_logic_vector(1 downto 0);  
C: in integer range 0 to 3; 
stato: out std_logic_vector(2 downto 0)
); 
end C1_15_02_2024;

architecture Beh of C1_15_02_2024 is
signal st: std_logic_vector(2 downto 0);
begin
     stato <= st;
     process(clk)
     begin
          if clk'event and clk = '0' then
             case st is 
                  when "000" => if Cond = '0' then st <= "001";
                                else st <= "000";
                                end if;
                  when "001" => if X = "01" then st <= "010";
                                else if X = "10" then st <= "011";
                                else if X = "11" then st <= "100";
                                else st <= "000";
                                end if;
                                end if;
                                end if;
                 when "010" => st <= "000";
                 when "011" => st <= "111";
                 when "100" => st <= "101";
                 when "101" => if C = 3 then st <= "000";
                               else if C < 3 then st <= "101";
                               end if;
                               end if;
                 when "111" => st <= "000";
            end case;
         end if;
     end process;
end Beh;
