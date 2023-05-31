asm_file = open("table_asm.txt")
asm_table = list(map(lambda f : f.rstrip("\n"), asm_file.readlines()))



Memoire = {} 

ligne = 0

while ligne < len(asm_table):

    instruction = asm_table[ligne].split()
    exp1 = int(instruction[1])
    exp2 = int(instruction[2])
    exp3 = int(instruction[3])

    if instruction[0] == "ADD":
        Memoire[exp1] = Memoire[exp2] + Memoire[exp3]
        print("Instruction :" + str(instruction)) 
        print("-> Memoire["+str(exp1)+"] : "+str(Memoire[exp1]))
        ligne += 1
    elif instruction[0] == "MUL":
        Memoire[exp1] = Memoire[exp2] * Memoire[exp3]
        print("Instruction :" + str(instruction)) 
        print("-> Memoire["+str(exp1)+"] : "+str(Memoire[exp1]))
        ligne += 1
    elif instruction[0] == "DIV":
        Memoire[exp1] = Memoire[exp2] / Memoire[exp3]
        print("Instruction :" + str(instruction)) 
        print("-> Memoire["+str(exp1)+"] : "+str(Memoire[exp1]))
        ligne += 1
    elif instruction[0] == "SUB":
        Memoire[exp1] = Memoire[exp2] - Memoire[exp3]
        print("Instruction :" + str(instruction)) 
        print("-> Memoire["+str(exp1)+"] : "+str(Memoire[exp1]))
        ligne += 1
    elif instruction[0] == "COP":
        Memoire[exp1] = Memoire[exp2]
        print("Instruction :" + str(instruction)) 
        print("-> Memoire["+str(exp1)+"] : "+str(Memoire[exp1]))
        ligne += 1
    elif instruction[0] == "AFC":
        Memoire[exp1] = exp2
        print("Instruction :" + str(instruction)) 
        print("-> Memoire["+str(exp1)+"] : "+str(Memoire[exp1]))
        ligne += 1
    elif instruction[0] == "JMP":
        ligne = exp1 
    elif instruction[0] == "JMF":
        if Memoire[exp2] == 0:
            ligne += 1 
        else:
            ligne = exp2

    elif instruction[0] == "INF":
        Memoire[exp1] = 1 if Memoire[exp2] < Memoire[exp3] else 0
        print("Instruction :" + str(instruction)) 
        print("-> Memoire["+str(exp1)+"] : "+str(Memoire[exp1]))
        ligne += 1
    elif instruction[0] == "SUP":
        Memoire[exp1] = 1 if Memoire[exp2] > Memoire[exp3] else 0
        print("Instruction :" + str(instruction)) 
        print("-> Memoire["+str(exp1)+"] : "+str(Memoire[exp1]))
        ligne += 1
    elif instruction[0] == "EQU":
        Memoire[exp1] = 1 if Memoire[exp2] == Memoire[exp3] else 0       
        print("Instruction :" + str(instruction)) 
        print("-> Memoire["+str(exp1)+"] : "+str(Memoire[exp1]))
        ligne += 1
    elif instruction[0] == "DIF":
        Memoire[exp1] = 1 if Memoire[exp2] != Memoire[exp3] else 0
        print("Instruction :" + str(instruction)) 
        print("-> Memoire["+str(exp1)+"] : "+str(Memoire[exp1]))
        ligne += 1
    elif instruction[0] == "AND":
        Memoire[exp1] = 1 if Memoire[exp2] and Memoire[exp3] else 0
        print("Instruction :" + str(instruction)) 
        print("-> Memoire["+str(exp1)+"] : "+str(Memoire[exp1]))
        ligne += 1
    elif instruction[0] == "OR":
        Memoire[exp1] = 1 if Memoire[exp2] or Memoire[exp3] else 0
        print("Instruction :" + str(instruction)) 
        print("-> Memoire["+str(exp1)+"] : "+str(Memoire[exp1]))
        ligne += 1
    elif instruction[0] == "PRI":
        print(Memoire[exp1])
        ligne += 1


