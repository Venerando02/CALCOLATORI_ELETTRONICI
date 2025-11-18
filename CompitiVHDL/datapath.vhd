----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.10.2025 10:03:06
-- Design Name: 
-- Module Name: datapath - Beh
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
use IEEE.std_logic_signed.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity datapath is
port (clk, WriteA, WriteB, WriteR, selA, selB: in std_logic;
      A, B: in std_logic_vector(7 downto 0);
      diversi, minore: out std_logic;
      ris: out std_logic_vector (7 downto 0)
      );
end datapath;

architecture Beh of datapath is
signal ma, mb: std_logic_vector (7 downto 0);

begin
     diversi <= '1' when ma /= mb else '0';
     minore <= '1' when ma < mb else '0'; 
     
     process(clk)
     begin 
          if clk'event and clk = '0' then 
             if WriteA = '1' then if selA = '0' then ma <= conv_std_logic_vector(0, 8); -- ma <= (others => '0'); ma <= conv_std_logic_vector(0,8)
                                                else ma <= ma + A;
                                                end if;
                              end if;
             if WriteB = '1' then if selB = '0' then mb <= conv_std_logic_vector(0, 8); -- ma <= (others => '0'); ma <= conv_std_logic_vector(0,8)
                                                else mb <= mb + B;
                                                end if;
                              end if;               
           end if;
           if WriteR = '1' then ris <= mb;
           end if;
     end process;
end Beh;
