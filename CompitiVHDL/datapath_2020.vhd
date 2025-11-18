----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.10.2025 15:26:26
-- Design Name: 
-- Module Name: datapath_2020 - beh
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
use IEEE.std_logic_signed.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity datapath_2020 is
port (d : std_logic_vector (31 downto 0);
      clk, Wa, Wo, Wr, comp: in std_logic;
      ris: out std_logic_vector (31 downto 0)
      );
end datapath_2020;

architecture beh of datapath_2020 is
signal A, aluRis: std_logic_vector (31 downto 0);
signal op: std_logic_vector (1 downto 0);
begin
     aluRis <= A + D when op = "00" else
               A - D when op = "01" else
               A or D;
process (clk)
begin 
     if clk'event and clk = '0' then
            if Wa = '1' then A <= D;
            end if;
            if Wo = '1' then op <= d(1 downto 0);
            end if;
            if Wr = '1' and comp = '1' then ris <= aluRis;
            end if;               
       end if;
end process;
end beh;
