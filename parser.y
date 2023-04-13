%{
#include <stdio.h>
#include <stdlib.h>
#include <ts.h>
int var[24];
%}

%code provides {
    int yylex(void);
    void yyerror(const char*);
} 

%union { int nb ; char str[16];}
%token tMAIN tPRINTF tRETURN  tIF tELSE tWHILE tVOID tTRUE tFALSE 
%token tLPAR tRPAR tLBRACE tRBRACE 
%token tCONST tINT tCOMMA tSEMI
%token tADD tSUB tMUL tDIV tEQ tLT tGT tNE tAND tOR tGE tLE tASSIGN tNOT
%token tCOMMENT tERROR
%token <nb> tNB
%token <str> tID

%%

Program : Function tVOID tMAIN tLPAR tVOID tRPAR Body ;

Function : tINT tID tLPAR ArgList tRPAR Body ;

ArgList : ArgListNext ;
        | %empty ;

ArgListNext : tINT tID ArgListNextNext 
            | Arith_Expr ArgListNextNext ;

ArgListNextNext : tCOMMA tINT tID ArgListNextNext
                 | tCOMMA Arith_Expr ArgListNextNext  
                 | %empty ;

Body : tLBRACE Content tRBRACE;

Content : Instruction Content
        | %empty; 

Instruction : Constantes
            | Declaration
            | Affectation
            | LoopIF 
            | LoopWHILE
            | Print 
            | Return 
            | tCOMMENT ;

Constantes : tCONST Dec tSEMI ;

Dec : tID tCOMMA DecNext ;
    |tID ; 
    |tID tASSIGN Arith_Expr ; 


Declaration : tINT DecNext tSEMI ;

DecNext : tID tCOMMA DecNext 
        | tID
        | tID tASSIGN Arith_Expr 
        | tID tASSIGN tID tLPAR ArgList tRPAR ; 

Affectation : tID tASSIGN Arith_Expr tSEMI ;
            


LoopIF : tIF tLPAR Condition tRPAR Body IfNext ;

IfNext : tELSE Body 
        | %empty ;


LoopWHILE : tWHILE tLPAR  Condition tRPAR  Body ; 


Arith_Expr : Factor 
           | Arith_Expr tADD Factor { $$ = $1 + $3 ;
           SYMBOLE s1 = {"x", 0, "int", 0, 0}; 
           pushTS(s1);}
           | Arith_Expr tSUB Factor;
            

Factor : Term 
       | Factor tMUL Term
       | Factor tDIV Term ;

Term : tNB 
     | tID  
     | tLPAR Arith_Expr tRPAR;


Condition : Bool_Expr 
          | Bool_Expr tAND Bool_Expr 
          | Bool_Expr tNOT Bool_Expr
          | Bool_Expr tOR Bool_Expr ;

Bool_Expr : tTRUE 
          | tFALSE 
          | Arith_Expr tLT Arith_Expr
          | Arith_Expr tGT Arith_Expr
          | Arith_Expr tGE Arith_Expr
          | Arith_Expr tLE Arith_Expr
          | Arith_Expr tNE Arith_Expr
          | Arith_Expr tEQ Arith_Expr ; 



Print : tPRINTF tLPAR Expr tRPAR tSEMI ; 

Return : tRETURN Expr tSEMI ; 

Expr : Arith_Expr 
     | Bool_Expr ;

%%

void yyerror(const char *msg) {
  fprintf(stderr, "error: %s\n", msg);
  exit(1);
}

int main(void) {
  yyparse();
}
