#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "ts.h"

int main()
{

    /* TESTS TABLE SYMBOLES */

    // Initialisation des symboles de test
    SYMBOLE s1 = {"x", 0, INT, 0, 0};
    SYMBOLE s2 = {"y", 1, INT, 4, 0};
    SYMBOLE s3 = {"z", 2, INT, 8, 1};
    SYMBOLE s4 = {"t", 3, INT, 12, 1};
    SYMBOLE s5 = {"u", 4, INT, 16, 2};
    SYMBOLE s6 = {"v", 5, INT, 20, 2};

    // Test de la fonction pushTS
    printf("Test de la fonction pushTS :\n");
    add_symb_var_ts(s1.nom,s1.isInit,s1.type);
    add_symb_var_ts(s2.nom,s2.isInit,s2.type);
    add_symb_var_ts(s3.nom,s3.isInit,s3.type);
    add_symb_var_ts(s4.nom,s4.isInit,s4.type);
    add_symb_var_ts(s5.nom,s5.isInit,s5.type);
    add_symb_var_ts(s6.nom,s6.isInit,s6.type);
    printf("Résultat attendu : La table des symboles contient 6 symboles.\n");
    printf("Résultat obtenu : La table des symboles contient %d symboles.\n", get_indexCst());
    print_TS_cst();

    // Test de la fonction getOffset
    printf("\nTest de la fonction getOffset :\n");
    int offset1 = get_addr_var_ts(s1.nom);
    int offset2 = get_addr_var_ts(s2.nom);
    int offset3 = get_addr_var_ts(s3.nom);
    printf("Résultat attendu : L'offset de %s est 0\n", s1.nom);
    printf("Résultat obtenu : L'offset de %s est %d\n", s1.nom, offset1);
    printf("Résultat attendu : L'offset de %s est 4\n", s2.nom);
    printf("Résultat obtenu : L'offset de %s est %d\n", s2.nom, offset2);
    printf("Résultat attendu : L'offset de %s est 8\n", s3.nom);
    printf("Résultat obtenu : L'offset de %s est %d\n", s3.nom, offset3);

    // Test de la fonction popTS
    printf("\nTest de la fonction rmv_symb_ts() :\n");
    rmv_symb_ts();
    rmv_symb_ts();
    printf("\nRemove u et v :\n");
    print_TS_cst();

    rmv_symb_ts();
    rmv_symb_ts();
    printf("\nRemove z et t :\n");
    print_TS_cst();

    rmv_symb_ts();
    rmv_symb_ts();
    printf("\nRemove x et y :\n");
    print_TS_cst();

    return 0;
}
