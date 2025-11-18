library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity T1C2_14022025 is
Port
( 
clk, start: in std_logic;  
op: in std_logic_vector(1 downto 0);  
conta: in integer range 0 to 2; 
stato: out std_logic_vector(2 downto 0)
); 
end T1C2_14022025;

architecture Beh of T1C2_14022025 is
signal st: std_logic_vector(2 downto 0);
begin
     stato <= st;
     process(clk)
     begin
          if clk'event and clk = '0' then 
          case st is
                  when "000" => if start = '1' then st <= "001";
                                else st <= "000";
                                end if;
                  when "001" => if op <= "00" then st <= "010";
                                else if op <= "01" then st <= "011";
                                else if op <= "1-" then st <= "100";
                                end if;
                                end if;
                                end if; 
                  when "010" => st <= "101";
                  when "011" => if conta = 1 then st <= "101";
                                             else st <= "011";
                                             end if;
                  when "100" => if conta = 2 then st <= "101";
                                             else st <= "100";
                                             end if;
                  when "101" => st <= "000";
          end case;
          end if;
     end process;
end Beh;
