----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.10.2025 16:51:35
-- Design Name: 
-- Module Name: Es8_31012023 - Beh
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
use IEEE.std_logic_signed.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Es8_31012023 is
port ( 
      clk: in std_logic;
      WRA, WRB: in std_logic;
      OP: in std_logic_vector (1 downto 0);
      Di: in std_logic_vector (15 downto 0);
      R: out std_logic_vector (15 downto 0)
      );
end Es8_31012023;

architecture Beh of Es8_31012023 is
signal A, B, AluRis: std_logic_vector(15 downto 0);
begin
     AluRis <= A + Di when OP = "00"
          else A + B when OP = "01"
          else A or Di when OP = "10";
     
     process(clk)
     begin
          if clk'event and clk = '0' then
                 if WRA = '1' then A <= Di;
                 end if;
                 if WRB = '1' then B <= AluRis;
                 end if;
          end if;
      end process;
end Beh;
