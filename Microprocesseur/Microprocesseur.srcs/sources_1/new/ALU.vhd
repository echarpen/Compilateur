----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.05.2023 16:13:23
-- Design Name: 
-- Module Name: ALU - Behavioral
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
use IEEE.std_logic_unsigned.ALL;
use IEEE.numeric_std.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU is
    Port ( A : in STD_LOGIC_VECTOR (7 downto 0);
           B : in STD_LOGIC_VECTOR (7 downto 0);
           Ctrl_Alu : in STD_LOGIC_VECTOR (2 downto 0);
           S : out STD_LOGIC_VECTOR (7 downto 0);
           N : out STD_LOGIC;
           O : out STD_LOGIC;
           Z : out STD_LOGIC;
           C : out STD_LOGIC);
end ALU;

architecture Behavioral of ALU is

signal S_aux : STD_LOGIC_VECTOR (15 downto 0); 

begin

--add
S_aux <= (x"00" & A) + (x"00" & B) when Ctrl_Alu = "001" else
-- mul 
    A * B when Ctrl_Alu = "010" else
-- sub 
    (x"00" & A) - (x"00" & B) when Ctrl_Alu = "011" else x"0000";
    
Z <= '1' when S_aux = x"0000" else '0' ;
C <= S_aux(7) when Ctrl_Alu = "001" else '0' ;
O <= '1' when (S_aux(15 downto 8) /= X"00") else '0' ;
N <= S_aux(7) when Ctrl_Alu = "011" else '0' ;

S <= S_aux (7 downto 0);

end Behavioral;
