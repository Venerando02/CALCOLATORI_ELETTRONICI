library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity C1_24_02_2023 is
Port
(
clk, start: in std_logic;  
Op: in std_logic_vector(1 downto 0);  
stato: out std_logic_vector(2 downto 0) 
); 
end C1_24_02_2023;

architecture Beh of C1_24_02_2023 is
signal st : std_logic_vector(2 downto 0);
begin
     stato <= st;
     process(clk)
     begin
     if clk'event and clk = '0' then
     case st is
     when "000" => if start = '1' then st <= "001";
                   else st <= "000";
                   end if;
     when "001" => if Op(0) = '0' then st <= "010";
                   else st <= "011"; 
                   end if;
     when "010" => st <= "100";
     when "011" => if Op(1) = '0' then st <= "101";
                   else st <= "000";
                   end if;
     when "100" => st <= "101";
     when "101" => st <= "000";
     end case; 
     end if;
     end process;
end Beh;
