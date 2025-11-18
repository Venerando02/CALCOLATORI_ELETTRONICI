----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.10.2025 15:36:58
-- Design Name: 
-- Module Name: C1_26032025 - beh
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

entity C1_26032025 is
port (
      clk, EnS: in std_logic;
      X, Y: in std_logic;
      C: in integer range 0 to 2;
      stato: out integer range 0 to 6
      );
end C1_26032025;

architecture beh of C1_26032025 is
signal st: integer range 0 to 6;
begin
     stato <= st;
     process(clk)
     begin
          if clk'event and clk = '1' then
                case st is 
                     when 0 => if EnS = '0' then st <= 0;
                               else st <= 1;
                               end if;
                     when 1 => if X = '0' then st <= 2;
                               else st <= 3;
                               end if;
                     when 2 => st <= 4;
                     when 3 => if Y = '1' then st <= 6;
                               else st <= 5;
                               end if;
                     when 4 => if C <= 2 then st <= 6;
                               else st <= 4;
                               end if;
                     when 5 => st <= 6;
                     when 6 => st <= 0;
                end case;
           end if;
      end process;
end beh;
