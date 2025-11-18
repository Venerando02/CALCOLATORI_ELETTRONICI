library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity C2_24_07_2023 is
port
(
clk, wa, wb, wr: in std_logic;
op: in std_logic;
D: in std_logic_vector(15 downto 0);
R: out std_logic_vector(15 downto 0)
);
end C2_24_07_2023;

architecture Beh of C2_24_07_2023 is
signal ARis: std_logic_vector(15 downto 0);
signal A, B: std_logic_vector(15 downto 0);
begin
     ARis <= A OR B when op = '0' else
             A + B;
     process(clk)
     begin
          if clk'event and clk = '0' then
                 if wa = '1' then A <= D;
                 end if;
                 if wb = '1' then B <= D;
                 end if;
                 if wr = '1' then R <= ARIs;
                 end if;
           end if;
     end process;
end Beh;
