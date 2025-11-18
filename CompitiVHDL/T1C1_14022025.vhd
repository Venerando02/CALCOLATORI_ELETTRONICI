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

entity T1C1_14022025 is
Port
(
clk, WeA, WeR: in std_logic;  
Din: in std_logic_vector(7 downto 0); 
op:   in std_logic_vector(1 downto 0); 
conta: in integer range 0 to 3; 
R:  out std_logic_vector(7 downto 0) 
);
end T1C1_14022025;

architecture Beh of T1C1_14022025 is
signal completed: std_logic;
signal A, AluRis: std_logic_vector(7 downto 0);
begin
     AluRis <= A + Din when op = "00" else
               A - Din when op = "01" else
               A or Din when op = "10" else
               A and Din;
     completed <= '1' when op(1) = '0' and conta < 3 else '0';
     process (clk)
     begin
          if clk'event and clk = '0' then
                 if WeA = '1' then A <= Din;
                              end if;
                 if WeR = '1' and completed = '1' then R <= AluRis;
                              end if;
          end if;
     end process;
end Beh;
