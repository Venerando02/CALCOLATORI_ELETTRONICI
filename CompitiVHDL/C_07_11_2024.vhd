library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity C_07_11_2024 is
Port
(
clk : in std_logic;  
ready, err, X: in std_logic;  
C: in integer range 0 to 2; 
stato: out std_logic_vector(2 downto 0)
);
end C_07_11_2024;

architecture Beh of C_07_11_2024 is
signal st: std_logic_vector(2 downto 0);
begin
    stato <= st;
    process(clk)
    begin
         if clk'event and clk = '1' then
         case st is 
              when "000" => if ready = '1' then st <= "001";
                            else st <= "000";
                            end if;
              when "001" => if err = '1' then st <= "000";
                            else if X = '0' and err = '0' then st <= "011";
                            else if X = '1' and err = '1' then st <= "010";
                            end if;
                            end if;
                            end if;
              when "010" => st <= "100";
              when "011" => st <= "000";
              when "100" => if C < 2 then st <= "100";
                            else if C = 2 then st <= "000";
                            end if;
                            end if; 
         end case;
         end if;
    end process;
end Beh;
