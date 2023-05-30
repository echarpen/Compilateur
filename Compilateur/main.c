#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "ts.h"
#include "asm_instruction.h"
#include "interpreter.h"

int main(int argc, char **argv){

    deleteTS();

    printf("-- PARSING\n");


    yyparse();

    FILE* ASM_file = fopen("./table_asm.txt", "w+");
    if(!ASM_file)  {
        perror("fopen");
        exit(EXIT_FAILURE);
    }
    asm_save_table(ASM_file);
    fclose(ASM_file); 

    printf("-- INTERPRETOR\n");
    interpret(get_last_line_asm());


    return 0;
}


