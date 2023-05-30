#include "asm_instruction.h"


// CREATION TABLE INSTRUCTION

Instruction ASM[ASM_SIZE];
int index_asm = 0;


// FCT QUI CREE L'INSTRUCTION EN ASM A PARTIR DU CODE

void add_instruc3(Operateur op, int expr1, int expr2, int expr3){
    Instruction instr = {index_asm, op, expr1, expr2, expr3};
    ASM[index_asm] = instr ;
    index_asm++;
}

void add_instruc2(Operateur op, int expr1, int expr2){
    Instruction instr = {index_asm, op, expr1, expr2, -1};
    ASM[index_asm] = instr ;
    index_asm++;
}

void add_instruc1(Operateur op, int expr1){
    Instruction instr = {index_asm, op, expr1, -1, -1};
    ASM[index_asm] = instr ;
    index_asm++;
}

void add_arithm(Operateur op){
    add_instruc3(op,get_second_to_last_tmp_addr(),get_second_to_last_tmp_addr(),get_last_tmp_addr());
    rmv_symb_tmp_ts(1);
}

// int add_boolean(Operateur op){
//     add_instruc3(op,get_second_to_last_tmp_addr(),get_second_to_last_tmp_addr(),get_last_tmp_addr());
//     //rmv_symb_tmp_ts(2);
//     return (get_second_to_last_tmp_addr());
// }


void add_cop(int addr) {
    add_instruc2(COP, addr, get_last_tmp_addr());
    //rmv_symb_tmp_ts(1);
}

void add_cop_bis(int to, int from ) {
    add_instruc2(COP, to, from);
    //rmv_symb_tmp_ts(1);
}

int add_jump(Operateur op, int expr1, int expr2){
    if (expr2 ==-1){
        add_instruc1(op,expr1);
    }
    else {
        add_instruc2(op, expr1, expr2);
    }
    return index_asm-1; 
}

// AUTRES

void patch_JMF(int from, int new ) { 
    ASM[from].expr2 = new ;
}

void patch_JMP(int from, int new ) { 
    ASM[from].expr1 = new ;
}


int get_last_line_asm(){
    return index_asm-1;
}

void asm_save_table(FILE* asm_file) {

    int i=0;
    while(i<index_asm) {
        fprintf(asm_file, 
            "%s %d %d %d \n", 
            Operateur_to_string(ASM[i].op), 
            ASM[i].expr1, 
            ASM[i].expr2, 
            ASM[i].expr3);
        i++;
    }


    fclose(asm_file); 
}

char* Operateur_to_string(Operateur o){
    switch (o){
        case ADD:
            return "ADD";
        case MUL:
            return "MUL";
        case SUB:
            return "SUB";
        case DIV:
            return "DIV";
        case COP:
            return "COP";
        case AFC:
            return "AFC";
        case JMP:
            return "JMP";
        case JMF:
            return "JMF";
        case INF:
            return "INF";
        case SUP:
            return "SUP";
        case EQU:
            return "EQU";
        case DIF:
            return "DIF";
        case AND:
            return "AND";
        case OR:
            return "OR";
        case PRI:
            return "PRI";
        default:
            return "";
    }
}


void print_tab_asm()
{
    printf("\n");
    printf("-------------------------------------------\n");
    printf("        TABLE DES INSTRUCTIONS\n");
    printf("-------------------------------------------\n");
    //printf("| Opérateur\t| Opérande 1\t| Opérande 2\t| Opérande 3\t|\n");
   
    for (int i = 0; i < index_asm; i++)
    {
        printf("L%d %s %d %d %d \n",
            ASM[i].ligne_nb, Operateur_to_string(ASM[i].op), ASM[i].expr1, ASM[i].expr2, ASM[i].expr3);
    }
    printf("-------------------------------------------\n");
    printf("\n");
}
