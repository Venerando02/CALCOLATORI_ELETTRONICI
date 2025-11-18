----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.10.2025 16:24:36
-- Design Name: 
-- Module Name: Es7_2022 - Beh
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
use IEEE.std_logic_signed.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Es7_2022 is
port 
( 
 Din: in std_logic_vector(15 downto 0);
 clk,WeA,WeB, WeR: in std_logic;
 R: out std_logic_vector(15 downto 0)
 );
end Es7_2022;

architecture Beh of Es7_2022 is
signal A, B, AluRis: std_logic_vector(15 downto 0);
begin
     AluRis <= A + B when Din < A else 
                          Din + B;
     process(clk)
     begin
          if clk'event and clk = '0' then
          if WeA = '1' then A <= Din;
                       end if;
          if WeB = '1' then B <= Din;
                       end if;
          if WeR = '1' then R <= AluRis;
                       end if;
          end if;
     end process;
     
end Beh;
