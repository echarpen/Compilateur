----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.05.2023 14:29:08
-- Design Name: 
-- Module Name: mem_instructions - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mem_instructions is
    Port ( adr : in STD_LOGIC_VECTOR (7 downto 0);
           CLK : in STD_LOGIC;
           sortie : out STD_LOGIC_VECTOR (31 downto 0));
end mem_instructions;

architecture Behavioral of mem_instructions is

type instructions is array (0 to 255) of STD_LOGIC_VECTOR(31 downto 0);
signal memoire_instructions : instructions := (
--    1 => "00000110" & "00000000" & "00000100" & "00000000", -- AFC

--    2  => "00000110" & "00000001" & "00000101" & "00000000",   --AFC 

--    3 => "00000001" & "00000010" & "00000000" & "00000001", --r2 (9) <- r0 + r1  ADD
     
--    4 => "00000011" & "00000011" & "00000010" & "00000000", --r3 (5) <- r2 - r0  SOU
    
--    5 => "00000010" & "00000110" & "00000011" & "00000010", -- r6 (45)<- r3 (5) * r2 (9) MUL
    
--    6 => "00001000" & "00000110" & "00000010" & "00000000", -- store r2 (9) at adress 6 STORE
     
--    7 => "00000111" & "00000100" & "00000110" & "00000000", -- load @6 () in r4 LOAD
     
     -- Test pour aleas
      1 => "00000110" & "00000000" & "00000101" & "00000000", -- AFC r0 <- 5
      2  => "00000101" & "00000001" & "00000000" & "00000000", --r1 <- r0 (5) COP
      3 => "00000001" & "00000010" & "00000000" & "00000001", -- ADD r2 <- r0 +r1 (=A)
    
    others => (others => '0')); 
 
 
begin

-- synchroniser sur la clock
process
begin 
    wait until (CLK'Event and CLK = '1');
        sortie <= memoire_instructions(to_integer(unsigned(adr))) ;
end process ;


end Behavioral;
