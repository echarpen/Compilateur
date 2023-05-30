asm_file = open("table_asm.txt")
asm_table = list(map(lambda f : f.rstrip("\n"), asm_file.readlines()))
asm_split = asm_table.asm_split()


Memoire = [] 

ligne = 0

while ligne < len(asm_table):

    exp1 = asm_table[ligne][1]
    exp2 = asm_table[ligne][2]
    exp3 = asm_table[ligne][3]

    match asm_table[ligne][0] :

        case ADD:
            Memoire[exp1]=Memoire[exp2]+Memoire[exp3]
        case MUL:

        case DIV:

        case SUB:
        
        case COP:

        case AFC:

        case JMP:
        
        case JMF:

        case INF:

        case SUP:

        case EQU:

        case DIF:

        case AND:

        case OR:

        case PRI:
