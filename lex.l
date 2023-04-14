%{
#include <stdio.h>
#include <stdlib.h>
#include "parser.tab.h"
%}


%option noyywrap
%option noinput
%option nounput

%x IN_COMMENT 

%%


"if" {return tIF ;}
"else" {return tELSE;}
"while" {return tWHILE;}
"print" {return tPRINTF;}
"return" {return tRETURN;}
"int" {return tINT;}
"void" {return tVOID;}
"main" {return tMAIN;}
"const" {return tCONST;}
"true" {return tTRUE;}
"false" {return tFALSE;}

"//".*$ {}

<INITIAL>{
  "/*"    { BEGIN(IN_COMMENT);} 
}
<IN_COMMENT>{
  "*/"     { BEGIN(INITIAL);} 
  [^*\n]+   
  "*"       
  \n    
}

"+" {return tADD;}
"-" {return tSUB;}
"*" {return tMUL;}
"/" {return tDIV;}
"<" {return tLT;}
">" {return tGT;}
"!=" {return tNE;}
"==" {return tEQ;}
">=" {return tGE;}
"<=" {return tLE;}
"=" {return tASSIGN;}
"&&" {return tAND;}
"||" {return tOR;}
"!" {return tNOT;}
"{" {return tLBRACE;}
"}" {return tRBRACE;}
"(" {return tLPAR;}
")" {return tRPAR;}
";" {return tSEMI;}
"," {return tCOMMA;}

" " {}
[ \t\n]+ {}

[a-zA-Z]+[a-zA-Z0-9]* {yyval.str, return tID;}
-?[0-9]+ {return tNB;}
[0x]+[0-9]+ {return tNB;}

. {return tERROR;} 

%%

/*int main(int argc, char *argv[])
  {
    yyin = fopen(argv[1],"r") ;
    yylex() ;
    fclose(yyin);
    return 0;
  }*/
  