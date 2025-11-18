----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.10.2025 10:27:49
-- Design Name: 
-- Module Name: T2_18022021 - Beh
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity T2_18022021 is
port
(
stato: in std_logic_vector(1 downto 0); 
en,cond: in std_logic; 
Sel, Write, Exe1, Exe2: out std_logic
);
end T2_18022021;

architecture Beh of T2_18022021 is
begin
     process(stato, en, cond)
     begin
          case stato is 
          when "00" => Sel <= '0'; Write <= '0';  Exe1 <= '0'; Exe2 <= '0'; 
                       
          when "01" => if en <= '1' then Sel <= '1'; Write <= '0'; Exe1 <= '0'; Exe2 <= '0';
                       else if en <= '0' then Sel <= '0'; Write <= '0'; Exe1 <= '0';  Exe2 <= '0';
                       end if;
                       end if;
          when "10" => if en <= '1' then Sel <= '1'; Write <= '1'; Exe1 <= '0'; Exe2 <= '0';
                       else if en <= '0' then Sel <= '0'; Write <= '1'; Exe1 <= '0';  Exe2 <= '0';
                       end if;
                       end if;
          when "11" => if cond <= '0' then Sel <= '0'; Write <= '0'; Exe1 <= '1'; Exe2 <= '1';
                       else if cond <= '1' then Sel <= '0'; Write <= '0'; Exe1 <= '0'; Exe2 <= '1';
                       end if;
                       end if;
          end case;
        end process;   
end Beh;
