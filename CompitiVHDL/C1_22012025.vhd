----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.10.2025 17:26:03
-- Design Name: 
-- Module Name: C1_22012025 - beh
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

entity C1_22012025 is
Port
( 
clk: in std_logic;  
avvio, en, op: in std_logic;  
conta: in integer range 0 to 3; 
stato: out integer range 0 to 4 
); 
end C1_22012025;

architecture beh of C1_22012025 is
signal st: integer range 0 to 4;
begin
     stato <= st;
     process(clk)
     begin
            if clk'event and clk = '1' 
            then case st is
                 when 0 => if avvio <= '1' then st <= 1;
                           end if;
                 when 1 => if en = '1' then if op = '1' 
                                       then st <= 3;
                                       else st <= 2;
                                       end if;
                           else st <= 0;
                           end if;
                 when 2 => st <= 4;
                 when 3 => if conta = 3 then st <= 4;
                                              end if;
                 when 4 => st <= 0;          
            end case;
            end if; 
      end process;
end beh;
