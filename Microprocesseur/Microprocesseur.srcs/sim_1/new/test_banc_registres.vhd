----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.05.2023 12:39:14
-- Design Name: 
-- Module Name: test_banc_registres - Behavioral
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

entity test_banc_registres is
--  Port ( );
end test_banc_registres;

architecture Behavioral of test_banc_registres is

-- component a tester
component banc_registres 
Port ( A_adr : in STD_LOGIC_VECTOR (3 downto 0);
       B_adr : in STD_LOGIC_VECTOR (3 downto 0);
       W_adr : in STD_LOGIC_VECTOR (3 downto 0);
       W : in STD_LOGIC;
       Data : in STD_LOGIC_VECTOR (7 downto 0);
       RST : in STD_LOGIC;
       CLK : in STD_LOGIC;
       QA : out STD_LOGIC_VECTOR (7 downto 0);
       QB : out STD_LOGIC_VECTOR (7 downto 0));
end component ;

--input 
signal CLK_BR : STD_LOGIC := '0';
signal A_adr_BR : STD_LOGIC_VECTOR (3 downto 0) := "0000";
signal B_adr_BR : STD_LOGIC_VECTOR (3 downto 0) := "0001";
signal W_adr_BR : STD_LOGIC_VECTOR (3 downto 0) ;
signal W_BR : STD_LOGIC := '1' ;
signal Data_BR : STD_LOGIC_VECTOR (7 downto 0) ;
signal RST_BR : STD_LOGIC := '1';
--output 
signal QA_BR : STD_LOGIC_VECTOR (7 downto 0);
signal QB_BR : STD_LOGIC_VECTOR (7 downto 0);

constant CLK_period : time := 10 ns;

begin

-- instantiation de BR
label_BR : banc_registres PORT MAP(
CLK => CLK_BR,
A_adr => A_adr_BR,
B_adr => B_adr_BR,
W_adr => W_adr_BR,
W => W_BR,
Data => Data_BR,
RST => RST_BR,
QA => QA_BR,
QB => QB_BR
);

-- clock process
CLK_process : process 
begin 
    CLK_BR <= not(CLK_BR);
    wait for CLK_period/2;
end process ;

-- stimulus process


Data_BR <= "00000010" after 10 ns, "00000100" after 30 ns, "00000111" after 100 ns;
W_adr_BR <= "0000" after 10 ns, "0001" after 30 ns, "0010" after 100 ns;
W_BR <= '0' after 50 ns, '1' after 100 ns;
RST_BR <= '0' after 80 ns;
A_adr_BR <= "0010" after 100 ns;


end Behavioral;
