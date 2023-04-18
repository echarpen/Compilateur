#ifndef ASM_INSTRUCTION_H
#define ASM_INSTRUCTION_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "ts.h"

#define ASM_SIZE 500 

typedef enum {ADD, MUL, SUB, DIV, COP, AFC, JMP, JMF, INF, SUP, EQU, DIF, AND, OR, PRI} Operateur ;

typedef struct {
    int ligne_nb;
    Operateur op;
    int expr1;
    int expr2;
    int expr3;
} Instruction ;


void add_instruc3(Operateur op, int expr1, int expr2, int expr3); //ajout d'une instruction avec 3 opérandes
void add_instruc2(Operateur op, int expr1, int expr2); //ajout d'une instruction avec 2 opérandes
void add_instruc1(Operateur op, int expr1); //ajout d'une instruction avec 1 opérande
void add_arithm(Operateur op); //ajout d'une expr arithmetique dans la table d'assembleur
void add_cop(int addr);
char* Operateur_to_string(Operateur o);
void print_tab_asm();

#endif