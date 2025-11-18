----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.10.2025 17:59:15
-- Design Name: 
-- Module Name: C2_22012025 - Beh
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
use IEEE.std_logic_unsigned.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity C2_22012025 is
Port
(
clk, WeA, WeB, WeC: in std_logic;  
Din: in std_logic_vector(7 downto 0); 
op:   in std_logic_vector(1 downto 0); 
R:  out std_logic_vector(7 downto 0)
); 
end C2_22012025;

architecture Beh of C2_22012025 is
signal A, B, C, aluRis: std_logic_vector(7 downto 0);
begin
     aluRis <= A+B when op = "00" else 
               A+C when op = "01" else 
               A or B when op = "10" else
               A and C;
     process(clk)
     begin
          if clk'event and clk = '0' then
                 if WeA = '1' then A <= Din;
                              end if;
                 if WeB = '1' then B <= Din;
                              end if;
                 if WeC = '1' then C <= aluRis; 
                              end if;
          end if;
    end process;      
end Beh;
