----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.10.2025 10:37:29
-- Design Name: 
-- Module Name: C1_14032023 - Beh
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

entity C1_14032023 is
Port
(
clk, start: in std_logic;  
Op,ready: in std_logic;  
stato: out integer range 0 to 5 
);
end C1_14032023;

architecture Beh of C1_14032023 is
signal st: integer range 0 to 5;
begin
     stato <= st;
     process(clk)
     begin
          if clk'event and clk = '0' then
          case st is
          when 0 => if start = '1' then st <= 1;
                    else st <= 0;
                    end if;
          when 1=> st <= 2;
          when 2 => if ready = '1' then if Op = '1' then st <= 4;
                    else if Op = '0' then st <= 3; 
                    end if;
                    end if;
                    end if;
          when 3 => st <= 0;
          when 4 => st <= 5;
          when 5 => st <= 0;  
          end case;
      end if;
      end process;
end Beh;
