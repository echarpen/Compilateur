#include <stdio.h>
#include <stdlib.h>

#define TS_SIZE 1000

/* TYPES */
// enum type {int} ;

typedef struct
{
    char *nom;
    int isInit;
    char *type; // entier sur 1 octet
    int offset;
    int scope;
} SYMBOLE;

/* VARIABLES */

SYMBOLE TS[TS_SIZE];
int index = 0;

/* FONCTIONS */

int pushTS(SYMBOLE S)
{

    // Vérifier si le symbole est déjà déclaré
    for (int i = 0; i < index; i++)
    {
        if (strcmp(TS[i].nom, S.nom) == 0 && TS[i].scope == S.scope)
        {
            fprintf(stderr, "Erreur : Le symbole '%s' est déjà déclaré dans ce scope\n", S.nom);
            return 0; // Retourne 0 pour indiquer une erreur
        }
    }

    // Ajouter le symbole à la table des symboles
    if (index < TS_SIZE)
    {
        TS[index] = S;
        index++;
        return 1; // Retourne 1 pour indiquer une insertion réussie
    }
    else
    {
        fprintf(stderr, "Erreur : La table des symboles est pleine\n");
        return 0; // Retourne 0 pour indiquer une erreur
    }
}

void popTS(int scope) // pop le dernier symbole si son scope est égal au scope donné
{
    if (index > 0)
    {
        if (TS[index - 1].scope == scope)
        {
            index--;
        }
    }
    else
    {
        fprintf(stderr, "Erreur : La table des symboles est vide\n");
    }
}

int getOffset(char *var)
{
    for (int i = index - 1; i >= 0; i--)
    {
        if (strcmp(TS[i].nom, var) == 0)
        {
            return TS[i].offset;
        }
    }
    // La variable n'a pas été trouvée dans la table des symboles
    fprintf(stderr, "Erreur : la variable '%s' n'a pas été déclarée.\n", var);
}

void printTS()
{
    printf("-----------------------------------------\n");
    printf("   TABLE DES SYMBOLES\n");
    printf("-----------------------------------------\n");
    printf("Nom\t| isInit\t| Type\t| Offset\t| Profondeur\n");
    for (int i = 0; i < index; i++)
    {
        printf("%s\t| %d\t| %s\t| %d\t| %d\n",
               TS[i].nom, TS[i].isInit, TS[i].type, TS[i].offset, TS[i].scope);
    }
}
