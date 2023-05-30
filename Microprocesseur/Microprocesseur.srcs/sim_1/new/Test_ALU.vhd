----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.05.2023 17:17:37
-- Design Name: 
-- Module Name: Test_ALU - Behavioral
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

entity Test_ALU is
--  Port ( );
end Test_ALU;

architecture Behavioral of Test_ALU is

component ALU 
Port ( A : in STD_LOGIC_VECTOR (7 downto 0);
           B : in STD_LOGIC_VECTOR (7 downto 0);
           Ctrl_Alu : in STD_LOGIC_VECTOR (2 downto 0);
           S : out STD_LOGIC_VECTOR (7 downto 0);
           N : out STD_LOGIC;
           O : out STD_LOGIC;
           Z : out STD_LOGIC;
           C : out STD_LOGIC);
end component; 

signal A_test : STD_LOGIC_VECTOR (7 downto 0) := "00000001";
signal B_test : STD_LOGIC_VECTOR (7 downto 0) := "00000100"; 
signal Ctrl_Alu_test : STD_LOGIC_VECTOR (2 downto 0) := (others => '0') ; 

signal S_test : STD_LOGIC_VECTOR (7 downto 0);
signal N_test : STD_LOGIC ;
signal O_test : STD_LOGIC ;
signal Z_test : STD_LOGIC ;
signal C_test : STD_LOGIC ;

begin

Label_uut : ALU PORT MAP(
    A => A_test,
    B => B_test,
    Ctrl_Alu => Ctrl_Alu_test,
    S => S_test,
    N => N_test,
    O => O_test,
    Z => Z_test,
    C => C_test
);

Ctrl_Alu_test <= "001" after 00ns, "010" after 50ns, "011" after 100ns;

end Behavioral;
