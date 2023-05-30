#include "interpreter.h"


/* Variables globales */ 

Instruction ASM[ASM_SIZE];
int MEMORY[MEM_SIZE];
int ligne = 0;


void interprete(int nb_instr) {

    print_tab_asm();

    memset(MEMORY, -1, sizeof(MEMORY));

    int exp1, exp2, exp3; 

    /* Parcourir toutes la table des instructions */
    while(ligne<nb_instr) {
        //printf("%s\n", asm_op_toString(ASM[ligne].op));
        exp1=ASM[ligne].expr1;
        exp2=ASM[ligne].expr2;
        exp3=ASM[ligne].expr3;

        /* Traitement selon l'opérateur */ 
        switch(ASM[ligne].op) {
            // ADD
            case ADD :
                MEMORY[exp1]=MEMORY[exp2]+MEMORY[exp3];
                ligne++;
                break; 

            // MUL
            case MUL :
                MEMORY[exp1]=MEMORY[exp2]*MEMORY[exp3];
                ligne++;
                break;

            // SUB
            case SUB : 
                MEMORY[exp1]=MEMORY[exp2]-MEMORY[exp3];
                ligne++;
                break; 

            // COP
            case COP : 
                MEMORY[exp1]=MEMORY[exp2];
                ligne++;
                break;

            // AFC 
            case AFC :
                MEMORY[exp1]=exp2;
                ligne++;
                break;

            // JMP
            case JMP : 
                ligne=exp1;
                break; 

            // JMF
            case JMF : 
                if (!MEMORY[exp1]) {
                    ligne=exp2;
                }
                else {
                    ligne++;
                }
                break; 

            // INF
            case INF : 
                MEMORY[exp1]=MEMORY[exp2]<MEMORY[exp3];
                ligne++;
                break; 

            // SUP
            case SUP : 
                MEMORY[exp1]=MEMORY[exp2]>MEMORY[exp3];
                ligne++;
                break;

            // EQU
            case EQU : 
                MEMORY[exp1]=MEMORY[exp2]==MEMORY[exp3];
                ligne++;
                break; 

            //DIF
            case DIF : 
                MEMORY[exp1]=MEMORY[exp2]!=MEMORY[exp3];
                ligne++;
                break; 

            // AND
            case AND : 
                MEMORY[exp1]=MEMORY[exp2]&&MEMORY[exp3];
                ligne++;
                break;

            // OR
            case OR :
                MEMORY[exp1]=MEMORY[exp2]||MEMORY[exp3];
                ligne++;
                break;

            // PRI
            case PRI : 
                printf("%d\n", MEMORY[exp1]);
                ligne++;
                break; 

        }
    }

}