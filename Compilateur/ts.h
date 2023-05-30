#ifndef TS_H
#define TS_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define TS_SIZE 200

typedef enum {INT, CHAR} TypeTS ; //enlever char ?

typedef struct
{
    char nom[16];
    int isInit;
    TypeTS type;
    int offset;
    int scope;
} SYMBOLE;


void add_symb_var_ts(char nom[16], int isInit, TypeTS type); // ajoute une var à la table des symboles
void add_symb_tmp_ts(); // ajoute une var tmp à la table des symboles
void rmv_symb_ts(); // suprime la dernière var 
void rmv_symb_tmp_ts(int combien); // supprime combien var tmp
void ts_init(char nom[16]); //pas isInit à 1
int get_addr_var_ts(char var[16]); // renvoie l'@ de var
int get_last_tmp_addr(); // renvoie l'@ de la dernière var tmp
int get_second_to_last_tmp_addr(); // renvoie l'@ de l'avant dernière var tmp
int get_indexCst(); //recupere l'indexCst
int symb_in_ts(char var[16]); // renvoie 1 si le symbole est dans la table, 0 sinon
void decrease_scope_ts(); // diminue le global scope et supprime les variables obsolètes
void increase_scope_ts(); // augmente le global scope
void deleteTS();
char* TypeTS_to_string(TypeTS t);
void print_TS_cst();  // affiche la table des symboles (non temporaires)
void print_TS_tmp();


#endif