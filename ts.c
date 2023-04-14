#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ts.h>

#define TS_SIZE 200


/********************************/
/* VARIABLES GLOBALES */
/********************************/


SYMBOLE TS[TS_SIZE];
int indexCst = 0;
int indexTmp = 199;
int global_scope = 0;


/********************************/
/* FONCTIONS */
/********************************/


// ADD, RMV

/**
 * @brief Add a symbol to the symbol table
 *
 * @param S
 * @return int
 */
int add_symb_var_ts(char nom[16], int isInit, TypeTS type)
{

    // Vérifier si le symbole est déjà déclaré
    for (int i = 0; i < indexCst; i++)
    {
        if (strcmp(TS[i].nom, nom) == 0)
        {
            fprintf(stderr, "Erreur : Le symbole '%s' est déjà déclaré dans ce scope\n", nom);
            return 0; // Retourne 0 pour indiquer une erreur
        }
    }

    // Ajouter le symbole à la table des symboles
    if (indexCst < TS_SIZE)
    {
        strcopy(nom, TS[indexCst].nom);
        TS[indexCst].isInit = isInit;
        TS[indexCst].type = type;
        // A MODIFIER offset !!!!!!!!
        TS[indexCst].offset = 1;
        TS[indexCst].type = type;
        TS[indexCst].scope = global_scope;
        indexCst++;
        return 1; // Retourne 1 pour indiquer une insertion réussie
    }
    else
    {
        fprintf(stderr, "Erreur : La table des symboles est pleine\n");
        return 0; // Retourne 0 pour indiquer une erreur
    }
}

int add_symb_tmp_ts(int isInit, TypeTS type)
{
    //Si il reste des emplacements pour les variables temporaires
    if (indexTmp < indexCst)
    {
        TS[indexCst].isInit = isInit;
        TS[indexCst].type = type;
        // A MODIFIER offset !!!!!!!!
        TS[indexCst].offset = 1;
        TS[indexCst].type = type;
        TS[indexCst].scope = global_scope;
        indexCst++;
        indexTmp--;
        return 1; // Retourne 1 pour indiquer une insertion réussie
    }
    else
    {
        fprintf(stderr, "Erreur : La table des symboles temporaires est pleine\n");
        return 0; // Retourne 0 pour indiquer une erreur
    }

}

/**
 * @brief Remove symbol from the symbol table if fund with same scope
 *
 * @param scope
 */
int rmv_symb_ts() // pop le dernier symbole
{
    if (indexCst > 0)
    {
        indexCst--;
        return 1;
    }
    else
    {
        fprintf(stderr, "Erreur : La table des symboles est vide\n");
        return 0; // Retourne 0 pour indiquer une erreur
    }
}

int rmv_symb_tmp_ts(int combien)
{
    if (combien == 1)
    {
        if (indexTmp = TS_SIZE-1)
        {
            fprintf(stderr, "Erreur : La table des symboles est vide\n");
            return 0; // Retourne 0 pour indiquer une erreur
        }
        else 
        {
            indexTmp++;
            return 1;
        }
    }
    else if (combien == 2)
    {
        if (indexTmp = TS_SIZE-2)
        {
            fprintf(stderr, "Erreur : Il n'y a pas deux var temp à suppriner dans la table des symboles\n");
            return 0; // Retourne 0 pour indiquer une erreur
        }
        else 
        {
            indexTmp++;
            indexTmp++;
            return 1;
        }
    }

}

// RECUP INFO

// /**
//  * @brief Get the Offset of var if found else return -1
//  *
//  * @param var
//  * @return int
//  */
// int get_offset_ts(char var[16])
// {

//     for (int i = indexCst - 1; i >= 0; i--)
//     {
//         if (strcmp(TS[i].nom, var) == 0)
//         {
//             return TS[i].offset;
//         }
//     }

//     // Si rien de trouve on renvoie -1
//     return -1;

//     // La variable n'a pas été trouvée dans la table des symboles
//     fprintf(stderr, "Erreur : la variable '%s' n'a pas été déclarée.\n", var);
// }


int get_addr_var_ts(char var[16]){

    int addr ; 
    for (int i=0; i<indexCst; i++) {
        if (strcmp(TS[i].nom,var) == 0) {
            addr = TS[i].offset;
            break; 
        } 
    }
    return addr;
}


int get_last_tmp_addr() {

    return TS[indexTmp-1].offset;

}

int get_second_to_last_tmp_addr() {
        
    return TS[indexTmp-2].offset;

}


// AUTRE

int symb_in_ts(char var[16]){
    int found = 0;
    int index = indexCst-1;
    
    while (!(found) && index>=0){
        if((strcmp(TS[index].nom,var) == 0)){
            found = 1;
        }
        index--;
    }
    
    return found;
}


/**
 * @brief decrease global depth to n-1 and remove symboles of depth n
 * 
 */
void decrease_scope_ts(){
    int n = TS[indexCst-1].scope ;
    
    while (TS[indexCst-1].scope == n) {
        indexCst--;   
    }
    
    global_scope--;
}

void increase_scope_ts(){
    global_scope++;
}

void deleteTS(){
    indexCst == 0;
    indexTmp == 199;
}


void print_TS_cst()
{
    printf("-----------------------------------------\n");
    printf("   TABLE DES SYMBOLES\n");
    printf("-----------------------------------------\n");
    printf("Nom\t| isInit\t| Type\t| Offset\t| Profondeur\n");
    for (int i = 0; i < indexCst; i++)
    {
        printf("%s\t| %d\t| %s\t| %d\t| %d\n",
               TS[i].nom, TS[i].isInit, TS[i].type, TS[i].offset, TS[i].scope);
    }
}

int main()
{
    return 1;
}