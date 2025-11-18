----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.10.2025 18:34:24
-- Design Name: 
-- Module Name: C2_25_01_2024 - Beh
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

entity C2_25_01_2024 is
Port
(
clk,op: in std_logic;  
WeA,WeC, selC: in std_logic;  
Din: in std_logic_vector(7 downto 0); 
R: out std_logic_vector(7 downto 0)
); 
end C2_25_01_2024;

architecture Beh of C2_25_01_2024 is
signal CONTA, nconta: integer range 0 to 2;
signal A, AluRis: std_logic_vector(7 downto 0);
signal WeR: std_logic;
begin
     nconta <= 0 when selC <= '1' else CONTA + 1;
     WeR <= '1' when CONTA <= 2 else '0';
     AluRis <= A + Din when op <= '0' else
               A - Din;
     process(clk)
     begin
          if clk'event and clk = '0' then
             if WeA <= '1' then A <= Din;
             end if;
             if WeC <= '1' then CONTA <= nconta;
             end if;
             if WeR <= '1' then R <= AluRis;
             end if;
          end if;
     end process;
end Beh;
