----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.10.2025 16:06:54
-- Design Name: 
-- Module Name: Esercitazione - Beh
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

entity Esercitazione is
port (
D: in std_logic_vector (7 downto 0);
Clk, S, OP, WA, WR: in std_logic;
Ris: out std_logic_vector (7 downto 0)
);
end Esercitazione;

architecture Beh of Esercitazione is
signal A, AluRis: std_logic_vector(7 downto 0);
signal conta, conta_in: integer range 0 to 3;
begin 
     conta_in <= 0 when S = '0' else
               conta+1;
     AluRis <= A or D when Op = '0' else
               A - D;
     process(clk)
     begin
          if clk'event and clk = '0' then
          conta <= conta_in;
          if WA = '1' then A <= D;
                           end if;
          if WR = '1' and conta = 2 then Ris <= AluRis;
                           end if;
          end if;
       end process;
end Beh;
