----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.10.2025 17:08:57
-- Design Name: 
-- Module Name: Es9_24012024 - beh
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

entity Es9_24012024 is
port (
 clk,op: in std_logic;
 WeA,WeC, selC: in std_logic;
 Din: in std_logic_vector(7 downto 0);
 R: out std_logic_vector(7 downto 0)
 );
end Es9_24012024;

architecture beh of Es9_24012024 is
signal A, risultato: std_logic_vector (7 downto 0);
signal conta, nconta: integer range 0 to 2;
signal WeR: std_logic;
begin
     WeR <= '1' when conta = 2 else '0';
     process(clk)
     begin
           if clk'event and clk = '0' then
           if WeA = '1' then A <= Din;
                        end if;
           if WeC = '1' then if selC = '0' then 
                             conta <= 0;
                             else conta <= conta + 1;
                             end if;
            end if;
            if WeR = '1' then if op = '0' then R <= A + Din;
                              else R <= A-Din;
                              end if;
            end if;
           end if;
      end process;
end beh;
