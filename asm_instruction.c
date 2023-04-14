#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ts.h>

// CREATION TABLE INSTRUCTION
#define ASM_SIZE 500 

Instruction asm[ASM_SIZE];
int index_asm = 0;


// FCT QUI CREE L'INSTRUCTION EN ASM A PARTIR DU CODE

void add_instruc3(Operateur op, int expr1, int expr2, int expr3){
    Instruction instr = {op, expr1, expr2, expr3};
    asm[index_asm] = instr ;
    index_asm++;
}

void add_instruc2(Operateur op, int expr1, int expr2){
    Instruction instr = {op, expr1, expr2, -1};
    asm[index_asm] = instr ;
    index_asm++;
}

void add_instruc1(Operateur op, int expr1){
    Instruction instr = {op, expr1, -1, -1};
    asm[index_asm] = instr ;
    index_asm++;
}

void add_arithm(Operateur op){
    add_instruc(op,get_second_to_last_tmp_addr(),get_second_to_last_tmp_addr(),get_last_tmp_addr());
    rmv_symb_tmp_ts(1);
}





void print_tab_asm()
{
    printf("-----------------------------------------\n");
    printf("   TABLE DES INSTRUCTIONS\n");
    printf("-----------------------------------------\n");
    printf("Operateur\t| Op1\t| Op2\t| Op3\t");
    for (int i = 0; i < index_asm; i++)
    {
        printf("%s\t| %d\t| %d\t| %d\n",
            asm[i].op, asm[i].expr1, asm[i].expr2, asm[i].expr3);
    }
}
