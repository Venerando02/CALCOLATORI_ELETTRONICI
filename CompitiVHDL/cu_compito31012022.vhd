----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.10.2025 11:19:35
-- Design Name: 
-- Module Name: cu_compito31012022 - beh
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

entity cu_compito31012022 is
port (clk, start: in std_logic;
      Op,cnt: in std_logic; 
      stato: out integer range 0 to 3 );
end cu_compito31012022;

architecture beh of cu_compito31012022 is
signal st: integer range 0 to 3;
begin 
     stato <= st;
     process(clk)
     begin
          if clk'event and clk = '0' then
             case st is
                when 0 => 	if start = '1' then st <= 1;
							else st <= 0;
							end if;
				when 1 =>   if op = '0' then st <= 2;
							else st <= 3;
							end if;
				when 2 => 	st <= 0;
				when 3 => 	if cnt = '1' then st <= 0;
							else st <= 3;
							end if;
			 end case;
		  end if;
	end process;		 
end beh;
