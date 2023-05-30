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
use IEEE.std_logic_unsigned.ALL;

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

-- Constant
constant NOP : STD_LOGIC_VECTOR(7 downto 0) := "00000000"; 
constant ADD : STD_LOGIC_VECTOR(7 downto 0) := "00000001";
constant MUL : STD_LOGIC_VECTOR(7 downto 0) := "00000010";
constant SOU : STD_LOGIC_VECTOR(7 downto 0) := "00000011";
constant DIV : STD_LOGIC_VECTOR(7 downto 0) := "00000100";
constant COP : STD_LOGIC_VECTOR(7 downto 0) := "00000101";
constant AFC : STD_LOGIC_VECTOR(7 downto 0) := "00000110";
constant LOAD : STD_LOGIC_VECTOR(7 downto 0) := "00000111";
constant STORE : STD_LOGIC_VECTOR(7 downto 0) := "00001000";


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

signal op1_in : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
signal a1_in, b1_in, c1_in : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
signal op1_out : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
signal a1_out, b1_out, c1_out : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');

signal op2_in : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
signal a2_in, b2_in, c2_in : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
signal op2_out : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
signal a2_out, b2_out, c2_out : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');

signal op3_in : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
signal a3_in, b3_in : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
signal op3_out : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
signal a3_out, b3_out : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');

signal op4_in : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
signal a4_in, b4_in: STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
signal op4_out : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
signal a4_out, b4_out : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');

-- Aléas 

signal alea : STD_LOGIC := '0' ;
signal num_nop : STD_LOGIC_VECTOR(1 downto 0) := "00";
signal EN_MI : STD_LOGIC := '1';

signal alea_write_3 : STD_LOGIC := '0';
signal alea_write_data_3 : STD_LOGIC := '0';
signal alea_write_2 : STD_LOGIC := '0';
signal alea_write_data_2 : STD_LOGIC := '0';

signal alea_read_1 : STD_LOGIC := '0';
signal alea_read_data_1 : STD_LOGIC := '0';
signal alea_read_alu_1 : STD_LOGIC := '0';



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

-- Etage 1 
op1_in <= MI_sortie(31 downto 24) when (EN_MI = '1');
a1_in <= MI_sortie(23 downto 16) when (EN_MI = '1');
b1_in <= MI_sortie(15 downto 8) when (EN_MI = '1'); 
c1_in <= MI_sortie(7 downto 0) when (EN_MI = '1'); 


 -- Etage 2 
BR_A_adr <= b1_out(3 downto 0);
BR_B_adr <= c1_out(3 downto 0);

op2_in <= op1_out;
a2_in <= a1_out;
b2_in <= BR_QA when (op1_out=ADD or op1_out=COP or op1_out=MUL or op1_out=SOU or op1_out=STORE) else b1_out; --mux
c2_in <= BR_QB; 


-- Etage 3
ALU_A <= b2_out ; 
ALU_B <= c2_out;
ALU_Ctrl <= op2_out(2 downto 0) when (op2_out=ADD or op2_out=MUL or op2_out=SOU) ; --LC

op3_in <= op2_out; 
a3_in <= a2_out; 
b3_in <= ALU_S when (op2_out=ADD or op2_out=MUL or op2_out=SOU) else b2_out;

 
-- Etage 4
MD_adr <= a3_out when (op3_out=STORE) else b3_out; 
MD_entree <= b3_out; 
MD_RW <= '1' when (op3_out=STORE) else '0';

op4_in <= op3_out;
a4_in <= a3_out;
b4_in <= MD_sortie when (op3_out=LOAD) else b3_out; 

    
    
-- Etage 5

BR_W_adr <= a4_out(3 downto 0);
BR_W <= '1' when (op4_out=ADD or op4_out=AFC or op4_out=COP or op4_out=MUL or op4_out=SOU or op4_out=LOAD) else '0';
BR_DATA <= b4_out;



--Alea 

-- Write
alea_write_3 <= '0' when (op3_in = NOP or op3_in = STORE) else '1';
alea_write_data_3 <= '1' when (op3_in = STORE) else '0';

alea_write_2 <= '0' when (op2_in = NOP or op2_in = STORE) else '1';
alea_write_data_2 <= '1' when (op2_in = STORE) else '0';

-- Read
alea_read_1 <= '0' when (op1_in = LOAD or op1_in = AFC) else '1';
alea_read_data_1 <= '1' when (op1_in = LOAD) else '0';
alea_read_alu_1 <= '1' when (op1_in = ADD or op1_in = SOU or op1_in = MUL or op1_in = DIV) else '0';


 alea <= '1' 
           when (
           --alea_1_2
               (alea_read_1 = '1' and alea_write_2 = '1' and alea_a2_in=alea_b1_in) or
               (alea_read_data_1 = '1' and alea_write_data_2 = '1' and alea_a2_in=alea_b1_in) or
               (alea_read_alu_1 = '1' and alea_a2_in=alea_c1_in) or
           --alea_1_3
               (alea_read_1 = '1' and alea_write_3 = '1' and alea_a3_in=alea_b1_in) or
               (alea_read_data_1 = '1' and alea_write_data_3 = '1' and alea_a3_in=alea_b1_in) or
               (alea_read_alu_1 = '1' and alea_a3_in=alea_c1_in)
           )
           else '0';

-- Séquentiel 
process (CLK_cd)
begin 
    if (CLK_cd'Event and CLK_cd='1') then 
    
        if(alea = '1' or (num_nop /= "00" and num_nop /= "11")) then
            op2_out <= NOP;
            a2_out <= "00000000";
            b2_out <= "00000000"; 
            c2_out <= "00000000";
            
            EN_MI <= '0';
        else
            num_nop <= "00";
            
            -- Etage 2
            op2_out <= op2_in;
            a2_out <= a2_in;
            b2_out <= b2_in; 
            c2_out <= c2_in;
            
            IP_adr <= IP_adr+1;
            EN_MI <= '1';
            
         end if;
            
               
        -- Etage 1
         op1_out <= op1_in; 
         a1_out <= a1_in; 
         b1_out <= b1_in; 
         c1_out <= c1_in;
                     
        -- Etage 3
        op3_out <= op3_in ;
        a3_out <= a3_in; 
        b3_out <= b3_in;
        
        -- Etage 4 
        op4_out <= op4_in;
        a4_out <= a4_in; 
        b4_out <= b4_in;
                                                      
        

    end if;
end process;

sortie <= b4_out;

end Behavioral;

