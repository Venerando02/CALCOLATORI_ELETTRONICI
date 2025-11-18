library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity C1_18_11_2024 is
Port
(
stato: in std_logic_vector(2 downto 0); 
En0, En1, Wr0, Wr1, Ready: out std_logic
); 
end C1_18_11_2024;

architecture Beh of C1_18_11_2024 is
begin
     process(stato)
     begin
          case stato is
          when "000" => En0 <= '0'; En1 <= '0'; Wr0 <= '0'; Wr1 <= '0'; Ready <= '1';
          when "001" => En0 <= '1'; En1 <= '0'; Wr0 <= '0'; Wr1 <= '0'; Ready <= '0';
          when "010" => En0 <= '0'; En1 <= '0'; Wr0 <= '0'; Wr1 <= '0'; Ready <= '0';
          when "011" => En0 <= '1'; En1 <= '0'; Wr0 <= '1'; Wr1 <= '0'; Ready <= '0';
          when "100" => En0 <= '0'; En1 <= '1'; Wr0 <= '0'; Wr1 <= '0'; Ready <= '0';
          when "101" => En0 <= '1'; En1 <= '1'; Wr0 <= '1'; Wr1 <= '1'; Ready <= '0';
          when "110" => En0 <= '0'; En1 <= '0'; Wr0 <= '0'; Wr1 <= '0'; Ready <= '0';
          when "111" => En0 <= '1'; En1 <= '0'; Wr0 <= '1'; Wr1 <= '1'; Ready <= '0';
          end case;
     end process;
end Beh;
