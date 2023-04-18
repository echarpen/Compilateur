%{
#include <stdio.h>
#include <stdlib.h>
#include "ts.h"
#include "asm_instruction.h"
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

Affectation : tID tASSIGN Arith_Expr tSEMI {
                        add_cop(get_addr_var_ts($1)); 
                        add_symb_var_ts($1,1, INT);
                        print_TS_cst();
                        print_tab_asm();
                        printf("Valeur de $1 %s",$1);
                        };
            


LoopIF : tIF tLPAR Condition tRPAR Body IfNext ;

IfNext : tELSE Body 
        | %empty ;


LoopWHILE : tWHILE tLPAR  Condition tRPAR  Body ; 


Arith_Expr : Factor 
           | Arith_Expr tADD Factor {
           // on genere la fct assembleur correspondante add @res @op1 @op2, on recup les operandes avec la ram, @res variable tempo
                add_symb_tmp_ts(0, INT);
                add_arithm(ADD);
                printf("ADD\n");
                print_tab_asm();}
           | Arith_Expr tSUB Factor{
                add_symb_tmp_ts(0, INT);
                add_arithm(SUB);
                printf("SUB\n");
                print_tab_asm();}
            
           //mettre actions simples, printf pour verifier que grammaire est bonne, printf ensuite transforme en fprintf des instructions en asm, il nous faut recuper l @ dans la ts

Factor : Term 
       | Factor tMUL Term
       | Factor tDIV Term ;

Term : tNB {
        add_symb_tmp_ts(0, INT);
        add_instruc2(AFC, get_last_tmp_addr(), $1);
        printf("op1 = %d\n",get_last_tmp_addr());
        printf("tNB\n");
        print_tab_asm();
        }
     | tID  {
        add_symb_tmp_ts(0, INT);
        add_instruc2(COP, get_last_tmp_addr(), get_addr_var_ts($1));
        printf("op1 = %d\n",get_last_tmp_addr());
        printf("tID\n");
        print_tab_asm();
        }
     | tLPAR Arith_Expr tRPAR;


Condition : Bool_Expr 
          | Bool_Expr tAND Bool_Expr {
                add_arithm(AND);
                printf("AND\n");
                print_tab_asm();
                add_symb_tmp_ts(0, INT);
            
          }
          | Bool_Expr tNOT Bool_Expr 
          | Bool_Expr tOR Bool_Expr {
                add_arithm(OR);
                printf("OR\n");
                print_tab_asm();
                add_symb_tmp_ts(0, INT);
          };

Bool_Expr : tTRUE 
          | tFALSE 
          | Arith_Expr tLT Arith_Expr{
                add_arithm(INF);
                printf("INF\n");
                print_tab_asm();
                add_symb_tmp_ts(0, INT);
          }
          | Arith_Expr tGT Arith_Expr {
                add_arithm(SUP);
                printf("SUP\n");
                print_tab_asm();
                add_symb_tmp_ts(0, INT);
          }
          | Arith_Expr tGE Arith_Expr
          | Arith_Expr tLE Arith_Expr
          | Arith_Expr tNE Arith_Expr
          | Arith_Expr tEQ Arith_Expr {
                add_arithm(EQU);
                printf("EQU\n");
                print_tab_asm();
                add_symb_tmp_ts(0, INT);
          }; 



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
