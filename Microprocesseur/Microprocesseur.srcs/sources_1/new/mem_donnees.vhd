----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.05.2023 13:53:18
-- Design Name: 
-- Module Name: mem_donnees - Behavioral
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

entity mem_donnees is
    Port ( adr : in STD_LOGIC_VECTOR (7 downto 0);
           entree : in STD_LOGIC_VECTOR (7 downto 0);
           RW : in STD_LOGIC;
           RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           sortie : out STD_LOGIC_VECTOR (7 downto 0));
end mem_donnees;

architecture Behavioral of mem_donnees is

type donnees is array (0 to 255) of STD_LOGIC_VECTOR(7 downto 0);
signal memoire_donnees : donnees ;

begin

-- synchroniser sur la clock
process
    begin 
        wait until (CLK'Event and CLK = '1');
        --reset
            if (RST = '0') then 
                memoire_donnees <= (others => x"00") ;
                -- ecriture
                elsif (RW = '1') then 
                    memoire_donnees(to_integer(unsigned(adr))) <= entree ;
            end if ;
       sortie <=  memoire_donnees(to_integer(unsigned(adr)));
    end process ;


end Behavioral;
