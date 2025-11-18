library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;

entity C2_24_02_2023 is
Port
(
clk, reset,op: in std_logic;  
WRA,WRB: in std_logic;  
Din: in std_logic_vector(7 downto 0); 
R: out std_logic_vector(7 downto 0) 
); 
end C2_24_02_2023;

architecture Beh of C2_24_02_2023 is
signal A, B: std_logic_vector(7 downto 0);
signal AluRis: std_logic_vector(7 downto 0);
begin
     AluRis <= A + B when op = '0' else
               A or B;
     A <= AluRis when reset <= '1' else
          "00000000";
     process(clk)
     begin
     if clk'event and clk = '0' then
            if WRA <= '1' then A <= AluRis;
            end if;
            if WRB <= '1' then B <= Din;
            end if;
     end if;
     end process;
end Beh;
