#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "ts.h"

int main()
{

    /* TESTS TABLE SYMBOLES */

    // Initialisation des symboles de test
    SYMBOLE s1 = {"x", 0, "int", 0, 0};
    SYMBOLE s2 = {"y", 1, "int", 4, 0};
    SYMBOLE s3 = {"z", 2, "int", 8, 1};
    SYMBOLE s4 = {"t", 3, "int", 12, 1};
    SYMBOLE s5 = {"u", 4, "int", 16, 2};
    SYMBOLE s6 = {"v", 5, "int", 20, 2};

    // Test de la fonction pushTS
    printf("Test de la fonction pushTS :\n");
    pushTS(s1);
    pushTS(s2);
    pushTS(s3);
    pushTS(s4);
    pushTS(s5);
    pushTS(s6);
    printf("Résultat attendu : La table des symboles contient 6 symboles.\n");
    printf("Résultat obtenu : La table des symboles contient %d symboles.\n", index);
    printTS();

    // Test de la fonction getOffset
    printf("\nTest de la fonction getOffset :\n");
    int offset1 = getOffset(s1.nom);
    int offset2 = getOffset(s2.nom);
    int offset3 = getOffset(s3.nom);
    printf("Résultat attendu : L'offset de %s est 0\n", s1.nom);
    printf("Résultat obtenu : L'offset de %s est %d\n", s1.nom, offset1);
    printf("Résultat attendu : L'offset de %s est 4\n", s2.nom);
    printf("Résultat obtenu : L'offset de %s est %d\n", s2.nom, offset2);
    printf("Résultat attendu : L'offset de %s est 8\n", s3.nom);
    printf("Résultat obtenu : L'offset de %s est %d\n", s3.nom, offset3);

    // Test de la fonction popTS
    printf("\nTest de la fonction popTS :\n");
    popTS(2);
    popTS(2);
    printf("\nPop de u et v :\n");
    printTS();

    popTS(1);
    popTS(1);
    printf("\nPop de z et t :\n");
    printTS();

    popTS(0);
    popTS(0);
    printf("\nPop de x et y :\n");
    printTS();

    return 0;
}
