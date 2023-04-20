#include "ts.h"



/********************************/
/* VARIABLES GLOBALES */
/********************************/


SYMBOLE TS[TS_SIZE];
int indexCst = 0;
int indexTmp = 199;
int global_scope = 0;
int global_offset = 0;


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
void add_symb_var_ts(char nom[16], int isInit, TypeTS type)
{

    // Vérifier si le symbole est déjà déclaré
    for (int i = 0; i < indexCst; i++)
    {
        if (strcmp(TS[i].nom, nom) == 0)
        {}
        else {
                fprintf(stderr, "Erreur add_symb_var_ts : Le symbole '%s' est déjà déclaré dans ce scope\n", nom);
            }
    }

    // Ajouter le symbole à la table des symboles
    if (indexCst < TS_SIZE)
    {
        strcpy(TS[indexCst].nom,nom);
        TS[indexCst].isInit = isInit;
        TS[indexCst].offset = global_offset;
        global_offset++;
        TS[indexCst].type = type;
        TS[indexCst].scope = global_scope;
        indexCst++;
    }
    else
    {
        fprintf(stderr, "Erreur : La table des symboles est pleine\n");
    }
}

/**
 * @brief ajoute un symbole dans le tableau temporaire 
 * 
 * @param isInit 
 * @param type 
 * @return int 
 */
void add_symb_tmp_ts()
{
    //Si il reste des emplacements pour les variables temporaires
    if (indexTmp > indexCst)
    {
        TS[indexTmp].isInit = 0;
        TS[indexTmp].offset = global_offset;
        global_offset++;
        TS[indexTmp].type = INT;
        TS[indexTmp].scope = global_scope;
        indexTmp--;
    }
    else
    {
        fprintf(stderr, "Erreur add_symb_tmp_ts : La table des symboles temporaires est pleine\n");
    }

}

/**
 * @brief Remove symbol from the symbol table if fund with same scope
 *
 * @param scope
 */
void rmv_symb_ts() // pop le dernier symbole
{
    if (indexCst > 0)
    {
        indexCst--;
    }
    else
    {
        fprintf(stderr, "Erreur rmv_symb_ts : La table des symboles est vide\n");
    }
}

void rmv_symb_tmp_ts(int combien)
{
    if (combien == 1)
    {
        if (indexTmp >= TS_SIZE-1)
        {
            fprintf(stderr, "Erreur rmv_symb_tmp_ts : La table des symboles est vide, rien à rmv\n");
        }
        else 
        {
            indexTmp++;
        }
    }
    else if (combien == 2)
    {
        if (indexTmp >= TS_SIZE-2)
        {
            fprintf(stderr, "Erreur rmv_symb_tmp_ts : Il n'y a pas deux var temp à suppriner dans la table des symboles\n");
        }
        else 
        {
            indexTmp++;
            indexTmp++;
        }
    }
}

void ts_init(char nom[16]) {
    int ind = get_addr_var_ts(nom) ; 
    TS[ind].isInit = 1 ;
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

    if (indexTmp == TS_SIZE-1){
        fprintf(stderr, "Erreur get_last_tmp_addr : La table des symboles est vide\n");
        return 0; // Retourne 0 pour indiquer une erreur
    }
    else {
        return TS[(indexTmp+1)].offset;
    }

}

int get_second_to_last_tmp_addr() {
        
    if (indexTmp == TS_SIZE-2){
        fprintf(stderr, "Erreur get_second_to_last_tmp_addr : Il n'y a pas de 2 var tmp\n");
        return 0; // Retourne 0 pour indiquer une erreur
    }
    else {
        return TS[(indexTmp+2)].offset;
    }

}

int get_indexCst(){
    return indexCst;
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
    indexCst = 0;
    indexTmp = 199;
}

char* TypeTS_to_string(TypeTS t){
    switch (t){
        case INT:
            return "INT";
            break;
        case CHAR:
            return "CHAR";
            break;
        default:
            return "";
            break;
    }
}

void print_TS_cst()
{
    printf("-----------------------------------------\n");
    printf("   TABLE DES SYMBOLES CONSTANTS \n");
    printf("-----------------------------------------\n");
    printf("Nom\t| isInit\t| Type\t| Offset\t| Profondeur\n");
    for (int i = 0; i < indexCst; i++)
    {
        printf("%s\t| %d\t| %s\t| %d\t| %d\n",
               TS[i].nom, TS[i].isInit, TypeTS_to_string(TS[i].type), TS[i].offset, TS[i].scope);
    }
}

void print_TS_tmp()
{
    printf("-----------------------------------------\n");
    printf("   TABLE DES VAR TEMPORAIRES \n");
    printf("-----------------------------------------\n");
    printf("Nom\t| isInit\t| Type\t| Offset\t| Profondeur\n");
    for (int i = indexTmp; i < TS_SIZE; i++)
    {
        printf("%s\t| %d\t| %s\t| %d\t| %d\n",
               TS[i].nom, TS[i].isInit, TypeTS_to_string(TS[i].type), TS[i].offset, TS[i].scope);
    }
}
/*int main()
{
    return 1;
}*/