----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.10.2025 15:32:47
-- Design Name: 
-- Module Name: C1_25_01_2024 - Beh
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

entity C1_25_01_2024 is
port(
clk : in std_logic;  
X: in std_logic_vector(1 downto 0);  
C: in integer range 0 to 2; 
stato: out std_logic_vector(2 downto 0)
);
end C1_25_01_2024;

architecture Beh of C1_25_01_2024 is
signal st: std_logic_vector(2 downto 0);
begin
    stato <= st;
    process(clk)
    begin
         if clk'event and clk = '1'
         then case st is
         when "000" => if X = "0-" then st <= "001";
                       else st <= "000";
                       end if;
         when "001" => if X = "1-" then st <= "000";
                       else if X = "01" then st <= "010";
                       else if X = "00" then st <= "011";
                       end if;
                       end if;
                       end if;
        when "010" =>  st <= "100";
        when "011" => if X = "-1" then st <= "101";
                      else if X = "-0" then st <= "000";
                      end if;
                      end if;
        when "100" => if C < 2 then st <= "011";
                      else st <= "101";
                      end if;
        when "101" => st <= "000";
        end case;
        end if;
    end process;
end Beh;
