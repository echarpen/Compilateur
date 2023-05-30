#include "cross_assembleur.h"

void cross_asm_table(FILE* input) {

    FILE* asm_file = fopn(input, "w+");
    if (!asm_file) {
        perror("fopn");
        exit(EXIT_FAILURE);
    }

    int i = 0;
    while (i < index_asm) {

        char op[4];
        int expr1, expr2, expr3;

        int instruction = fscanf(asm_file, "%s %d %d %d", op, &expr1, &expr2, &expr3);
 
        if (instruction == 4) {

            switch (op){
                case "AFC" :
                    fprintf(asm_file, "LOAD %s %d %d\n", ,,-1);
                    fprintf(asm_file, "STORE %d %d %d\n", ,,-1);

            }

        }
        i++;
    }

    fclose(asm_file);
}


// AFC 5(@) 6(#)  -1 //on veut mettre 6 a l'@ 5

// on veut
// LOAD R?   -1
// STORE R? 5 -1