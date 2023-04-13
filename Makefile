build: 
    bison -t -v -d parser.y
    flex lex.l
    gcc -o test parser.tab.c lex.yy.c

	gcc -c -Wall -g ts.c 
	gcc -Wall -g -o main ts.o main.o 



clean:
    rm test parser.tab.c lex.yy.c parser.tab.h parser.output

test:
    ./test < fonctionTest.c
