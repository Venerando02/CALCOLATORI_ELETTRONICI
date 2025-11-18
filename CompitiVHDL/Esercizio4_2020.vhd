----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.10.2025 15:06:39
-- Design Name: 
-- Module Name: Esercizio4_2020 - beh
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

entity Esercizio4_2020 is
port ( stato: in std_logic_vector (2 downto 0);
       en: in std_logic;
       WR1, WR2, exe, ready: out std_logic);
end Esercizio4_2020;

architecture beh of Esercizio4_2020 is
begin
     WR1 <= '1' when en = '1' and (stato = "000" or stato = "001") else '0';
     WR2 <= '1' when en = '1' and (stato = "000" or stato = "010") else '0';
     exe <= '1' when en = '1' and stato = "011" else '0';                
     ready <= '1' when en = '1' and stato = "011" else '0';
end beh;
