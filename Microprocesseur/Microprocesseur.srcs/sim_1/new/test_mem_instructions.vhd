----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.05.2023 14:38:47
-- Design Name: 
-- Module Name: test_mem_instructions - Behavioral
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

entity test_mem_instructions is
--  Port ( );
end test_mem_instructions;

architecture Behavioral of test_mem_instructions is

component mem_instructions 
Port ( adr : in STD_LOGIC_VECTOR (7 downto 0);
       CLK : in STD_LOGIC;
       sortie : out STD_LOGIC_VECTOR (31 downto 0));
end component ;

signal adr_MI : STD_LOGIC_VECTOR (7 downto 0) := x"00";
signal CLK_MI : STD_LOGIC := '1' ;
signal sortie_MI : STD_LOGIC_VECTOR (31 downto 0);

constant CLK_period : time := 10 ns;

begin

label_MI : mem_instructions PORT MAP(
adr => adr_MI,
CLK => CLK_MI,
sortie => sortie_MI
);

-- clock process
CLK_process : process 
begin 
    CLK_MI <= not(CLK_MI);
    wait for CLK_period/2;
end process ;

adr_MI <= "00000010" after 00 ns, "00000011" after 20ns ;

end Behavioral;
