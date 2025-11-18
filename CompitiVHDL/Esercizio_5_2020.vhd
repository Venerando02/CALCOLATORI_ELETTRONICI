----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.10.2025 15:14:28
-- Design Name: 
-- Module Name: Esercizio_5_2020 - beh
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

entity Esercizio_5_2020 is
port (d: in std_logic_vector (15 downto 0);
      clk, Wa, Wb, Wr : in std_logic;
      ris: out std_logic_vector (15 downto 0)
      );
end Esercizio_5_2020;

architecture beh of Esercizio_5_2020 is
signal A, B: std_logic_vector (15 downto 0);
begin
     process (clk)
     begin
          if clk'event and clk = '0' then 
                if Wa = '1' then A <= d;
                end if;
                if Wb = '1' then B <= d;
                end if;
                if Wr = '1' then case d(1 downto 0) is
                            when "00" => Ris <= A and B;
                            when "01" => Ris <= A - B;
                            when "10" => Ris <= A + B;
                            when others => null;
                            end case;
                end if;
            end if;
     end process;
end beh;
