library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;

entity T2C2_14_02_2025 is
port
(
clk, WeA, WeB, En: in std_logic;
Din: in std_logic_vector(15 downto 0);
op: in std_logic_vector(1 downto 0);
conta: in integer range 0 to 2;
R: out std_logic_vector(15 downto 0)
);
end T2C2_14_02_2025;

architecture Beh of T2C2_14_02_2025 is
signal A, B, AluRis: std_logic_vector(15 downto 0);
signal WeR: std_logic; 
begin
     AluRis <= A OR B when op = "00" else
               A AND B when op = "01" else
               A + B when op = "10" else
               A + B when op = "11";
     WeR <= '1' when En = '1' and conta = 2 else
            '0';
     process(clk)
     begin
     if clk'event and clk = '0' then
                  if WeA = '1' then A <= Din;
                  end if;
                  if WeB = '1' then B <= Din;
                  end if;
                  if WeR = '1' then R <= AluRis;
                  end if;
      end if;
     end process;
end Beh;
