----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.10.2025 15:52:41
-- Design Name: 
-- Module Name: C2_26032025 - behavioral
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
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity C2_26032025 is
port (
      clk, Op0, Op1, sel : in std_logic;
      WeA, WeB, WeR: in std_logic;
      Di: in std_logic_vector (15 downto 0);
      R: out std_logic_vector (15 downto 0)
      );
end C2_26032025;

architecture behavioral of C2_26032025 is
signal A, B: std_logic_vector (15 downto 0);
signal aluRis0, aluRis1, risultato: std_logic_vector (15 downto 0);

begin
     process (clk)
     begin
          if clk'event and clk = '0' then
             if WeA = '1' then A <= Di;
             end if;
             if WeB = '1' then B <= Di;
             end if;
             if WeR = '1' then R <= risultato;
             end if;
             if Op0 = '0' then aluRis0 <= A + B;
             else aluRis0 <= A - B;
             end if;
             if Op1 = '0' then aluRis1 <= Di or B;
             else aluRis1 <= Di and B; 
             end if;
                
         end if;
     end process;        
end behavioral;
