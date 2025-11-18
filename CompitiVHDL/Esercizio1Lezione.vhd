----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.10.2025 09:26:49
-- Design Name: 
-- Module Name: Esercizio1Lezione - Behavioral
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

entity Esercizio1Lezione is
port (clk, start, diversi, minori: in std_logic;
      ready: out std_logic); 
end Esercizio1Lezione;

architecture Behavioral of Esercizio1Lezione is
type stati is (idle, init, compare, agg_ma, agg_mb, agg_ris);
signal st: stati;
begin
     process(clk)
     begin 
          if clk' event and clk = '0' then
                 case st is 
                      when idle => if start = '1' then st <= init;
                      else st <= idle;
                      end if;
                      when init => st <= compare;
                      when compare => if diversi = '0' then st <= agg_ris;
                                      elsif diversi = '1' then st <= agg_ma;
                                      else st <= agg_mb;
                                      end if;
                      when agg_ma | agg_mb => st <= compare;
                      when agg_ris => st <= idle;
                  end case;
           end if;
           end process;
         ready <= '1' when st <= idle else '0';
end Behavioral;
