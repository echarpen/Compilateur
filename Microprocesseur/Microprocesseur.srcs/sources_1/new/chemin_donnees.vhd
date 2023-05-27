----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.05.2023 14:58:59
-- Design Name: 
-- Module Name: chemin_donnees - Behavioral
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

entity chemin_donnees is
    Port ( CLK_cd : in STD_LOGIC;
           RST_cd : in STD_LOGIC;
           sortie : out STD_LOGIC_VECTOR (7 downto 0));
end chemin_donnees;

architecture Behavioral of chemin_donnees is

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

component mem_donnees 
Port ( adr : in STD_LOGIC_VECTOR (7 downto 0);
       entree : in STD_LOGIC_VECTOR (7 downto 0);
       RW : in STD_LOGIC;
       RST : in STD_LOGIC;
       CLK : in STD_LOGIC;
       sortie : out STD_LOGIC_VECTOR (7 downto 0));
end component ;

component mem_instructions 
Port ( adr : in STD_LOGIC_VECTOR (7 downto 0);
       CLK : in STD_LOGIC;
       sortie : out STD_LOGIC_VECTOR (31 downto 0));
end component ;


-- Signaux composants
signal ALU_A : STD_LOGIC_VECTOR (7 downto 0);
signal ALU_B : STD_LOGIC_VECTOR (7 downto 0);
signal ALU_Ctrl : STD_LOGIC_VECTOR (2 downto 0);
signal ALU_S : STD_LOGIC_VECTOR (7 downto 0);
signal ALU_N : STD_LOGIC;
signal ALU_O : STD_LOGIC;
signal ALU_Z : STD_LOGIC;
signal ALU_C : STD_LOGIC;

signal BR_A_adr : STD_LOGIC_VECTOR (3 downto 0) := (others => '0') ;
signal BR_B_adr : STD_LOGIC_VECTOR (3 downto 0) := (others => '0') ;
signal BR_W_adr : STD_LOGIC_VECTOR (3 downto 0) := (others => '0') ;
signal BR_W : STD_LOGIC := '0' ;
signal BR_Data : STD_LOGIC_VECTOR (7 downto 0) := (others => '0') ;
signal BR_QA : STD_LOGIC_VECTOR (7 downto 0);
signal BR_QB : STD_LOGIC_VECTOR (7 downto 0);

signal MD_adr : STD_LOGIC_VECTOR (7 downto 0) := (others => '0') ;
signal MD_entree : STD_LOGIC_VECTOR (7 downto 0) := (others => '0') ;
signal MD_RW : STD_LOGIC := '1';
signal MD_sortie : STD_LOGIC_VECTOR (7 downto 0);

signal MI_adr : STD_LOGIC_VECTOR (7 downto 0) := (others => '0') ;
signal MI_CLK : STD_LOGIC;
signal MI_sortie : STD_LOGIC_VECTOR (31 downto 0) := (others => '0') ; 


--signaux intermediaires 

signal IP_adr : STD_LOGIC_VECTOR(7 downto 0) := (others => '0'); 

 

begin

my_alu: ALU PORT MAP(
        A => ALU_A, 
        B => ALU_B, 
        Ctrl_Alu => ALU_Ctrl, 
        S => ALU_S, 
        N => ALU_N, 
        O => ALU_O, 
        Z => ALU_Z, 
        C => ALU_C);
        
my_banc_registres : banc_registres port map(
        A_adr => BR_A_adr, 
        B_adr => BR_B_adr, 
        W_adr => BR_W_adr, 
        W => BR_W, 
        Data => BR_Data, 
        CLK => CLK_cd,
        RST => RST_cd,
        QA => BR_QA, 
        QB => BR_QB);
        
my_mem_donnees : mem_donnees port map(
        adr => MD_adr, 
        entree => MD_entree, 
        RW => MD_RW,
        CLK => CLK_cd, 
        RST => RST_cd,
        sortie => MD_sortie);
        
my_mem_instructions : mem_instructions port map(
        adr => MI_adr, 
        CLK => CLK_cd,
        sortie => MI_sortie);  

   -- IP
MI_adr <= IP_adr; 


end Behavioral;

