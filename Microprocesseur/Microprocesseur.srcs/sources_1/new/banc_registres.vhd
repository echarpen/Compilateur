----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.05.2023 17:52:41
-- Design Name: 
-- Module Name: banc_registres - Behavioral
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

entity banc_registres is
    Port ( A_adr : in STD_LOGIC_VECTOR (3 downto 0);
           B_adr : in STD_LOGIC_VECTOR (3 downto 0);
           W_adr : in STD_LOGIC_VECTOR (3 downto 0);
           W : in STD_LOGIC;
           Data : in STD_LOGIC_VECTOR (7 downto 0);
           RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           QA : out STD_LOGIC_VECTOR (7 downto 0);
           QB : out STD_LOGIC_VECTOR (7 downto 0));
end banc_registres;

architecture Behavioral of banc_registres is

type reg_array is array (0 to 15) of STD_LOGIC_VECTOR(7 downto 0);
signal registers : reg_array ;

begin
    process (CLK) 
    begin 
        -- synchronisation sur front montant 
        if (CLK'Event and CLK = '1') then 
            -- si reset
            if (RST = '0') then 
                registers <= (others => x"00") ;
                -- si en ecriture
                elsif (W = '1') then 
                    registers(to_integer(unsigned(W_adr))) <= Data ;
            end if ;
        end if;
            
    end process;
    -- bypass
    QA <= registers(to_integer(unsigned(A_adr))) when W_adr /= A_adr or W='0' else Data ;
    QB <= registers(to_integer(unsigned(B_adr))) when W_adr /= B_adr or W='0' else Data ;

end Behavioral;
