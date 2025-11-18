----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.10.2025 10:23:20
-- Design Name: 
-- Module Name: C1_09_09_2025 - Beh
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

entity C1_09_09_2025 is
port
(
op: in std_logic;
stato: in std_logic_vector(1 downto 0);
Rd, E0, E1, W0, W1, Ready: out std_logic
);
end C1_09_09_2025;

architecture Beh of C1_09_09_2025 is
begin
     process(stato)
     begin
          case stato is
          when "00" => if op <= '0' and op <= '1' then Rd <= '0'; E0 <= '0'; E1 <= '0'; W0 <= '0'; W1 <= '0'; Ready <= '1';
                       end if;
          when "01" => if op <= '0' and op <= '1' then Rd <= '1'; E0 <= '0'; E1 <= '1'; W0 <= '0'; W1 <= '0'; Ready <= '0';
                       end if;
          when "10" => if op <= '0' and op <= '1' then Rd <= '1'; E0 <= '1'; E1 <= '0'; W0 <= '0'; W1 <= '0'; Ready <= '0';
                       end if;
          when "11" => if op <= '1' then Rd <= '1'; E0 <= '0'; E1 <= '0'; W0 <= '1'; W1 <= '0'; Ready <= '0';
                       else Rd <= '1'; E0 <= '0'; E1 <= '0'; W0 <= '0'; W1 <= '1'; Ready <= '0';
                       end if;
          end case;
     end process;
end Beh;
