----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.10.2025 10:24:29
-- Design Name: 
-- Module Name: cu_es5 - beh
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

entity cu_es5 is
port (clk, start: in std_logic;
      OP: std_logic_vector(1 downto 0);
      conta: integer range 0 to 2;
      Ready: out std_logic
     );
end cu_es5;

architecture beh of cu_es5 is
type stati is (idle, readOP, readA, readB, exe1, exe2);
signal st: stati;
begin
     process (clk)
     begin 
          if clk'event and clk = '0' then
                 case st is
                      when idle => if start = '1' then st <= readOP;
                                   else st <= idle;
                                   end if;
                      when readOP => st <= readA;
                      when readA => st <= readB;
                      when readB => if OP(1) = '0' then st <= exe1; 
                                                   else st <= exe2;
                                                   end if;
                      when exe1 => st <= idle;
                      when exe2 => if conta < 2 then st <= exe2;
                                   else st <= idle;
                                   end if;
                  end case;
           end if;
     end process;
     ready <= '1' when st <= idle else '0';
end beh;
