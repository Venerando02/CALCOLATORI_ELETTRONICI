library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity C1_26_03_2024 is
Port
(
clk, Cond : in std_logic;  
X: in std_logic;  
C: in integer range 0 to 2; 
stato: out std_logic_vector(2 downto 0) 
); 
end C1_26_03_2024;

architecture Beh of C1_26_03_2024 is
signal st: std_logic_vector(2 downto 0);
begin
     stato <= st;
     process(clk)
     begin
          if clk'event and clk = '1' then
                 case st is
                 when "000" => if Cond = '0' then st <= "001";
                               else st <= "000";
                               end if;
                 when "001" => if X = '0' then st <= "010";
                               else st <= "011";
                               end if;
                 when "010" => st <= "100";
                 when "011" => st <= "101";
                 when "100" => if C < 2 then st <= "100";
                               else if C = 2 then st <= "101";
                               end if;
                               end if;
                 when "101" => st <= "000";
                 end case;
          end if;
     end process;
end Beh;
