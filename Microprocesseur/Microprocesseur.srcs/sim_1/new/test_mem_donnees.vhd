----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.05.2023 14:06:44
-- Design Name: 
-- Module Name: test_mem_donnees - Behavioral
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

entity test_mem_donnees is
--  Port ( );
end test_mem_donnees;

architecture Behavioral of test_mem_donnees is

component mem_donnees 
Port ( adr : in STD_LOGIC_VECTOR (7 downto 0);
       entree : in STD_LOGIC_VECTOR (7 downto 0);
       RW : in STD_LOGIC;
       RST : in STD_LOGIC;
       CLK : in STD_LOGIC;
       sortie : out STD_LOGIC_VECTOR (7 downto 0));
end component ;

signal adr_MD : STD_LOGIC_VECTOR (7 downto 0) := X"00" ;
signal entree_MD : STD_LOGIC_VECTOR (7 downto 0) ;
signal RW_MD : STD_LOGIC ;
signal RST_MD : STD_LOGIC := '1';
signal CLK_MD : STD_LOGIC := '0' ;
signal sortie_MD : STD_LOGIC_VECTOR (7 downto 0);

constant CLK_period : time := 10 ns;

begin

label_MD : mem_donnees PORT MAP(
adr => adr_MD,
entree => entree_MD,
RW => RW_MD,
RST => RST_MD,
CLK => CLK_MD,
sortie => sortie_MD
);

-- clock process
CLK_process : process 
begin 
    CLK_MD <= not(CLK_MD);
    wait for CLK_period/2;
end process ;

-- stimulus process
RW_MD <= '1' after 10 ns, '0' after 60 ns;
entree_MD <= "11111111" after 10 ns, "00001111" after 40 ns ;
adr_MD <= "00000001" after 30 ns, "00000010" after 50 ns;
RST_MD <= '0' after 80 ns;


end Behavioral;
