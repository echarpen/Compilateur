----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.05.2023 11:17:22
-- Design Name: 
-- Module Name: test_chemin_donnees - Behavioral
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

entity test_chemin_donnees is
--  Port ( );
end test_chemin_donnees;

architecture Behavioral of test_chemin_donnees is

component chemin_donnees 
Port ( CLK_cd : in STD_LOGIC;
       RST_cd : in STD_LOGIC;
       sortie : out STD_LOGIC_VECTOR ( 7 downto 0));
end component ;

signal CLK_test : STD_LOGIC := '0' ; 
signal RST_test : STD_LOGIC := '1' ; 
signal sortie_test : STD_LOGIC_VECTOR (7 downto 0);

constant CLK_period : time := 10 ns;


begin

label_cd : chemin_donnees PORT MAP(
    CLK_cd => CLK_test,
    RST_cd => RST_test,
    sortie => sortie_test
);

Clock_process : process
begin 
    CLK_test <= not(CLK_test);
    wait for CLK_period/2; 
end process;




end Behavioral;
