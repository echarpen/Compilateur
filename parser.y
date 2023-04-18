%{
#include <stdio.h>
#include <stdlib.h>
#include "ts.h"
#include "asm_instruction.h"
int var[24];
int line;
%}

%code provides {
    int yylex(void);
    void yyerror(const char*);
} 

%union { int nb ; char str[16];}
%token tMAIN tPRINTF tRETURN tELSE tWHILE tVOID tTRUE tFALSE 
%token tLPAR tRPAR tLBRACE tRBRACE 
%token tCONST tINT tCOMMA tSEMI
%token tADD tSUB tMUL tDIV tEQ tLT tGT tNE tAND tOR tGE tLE tASSIGN tNOT
%token tCOMMENT tERROR
%token <nb> tNB
%token <nb> tIF
%token <str> tID
%type <nb> Term 

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

Body : tLBRACE {increase_scope_ts();} Content tRBRACE {decrease_scope_ts();};

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

Dec : tID tCOMMA DecNext {if (symb_in_ts($1)){
                fprintf(stderr,"La constante existe deja 1\n");
                return 1;
            } else { add_symb_var_ts($1,0,INT);}};
    |tID {if (symb_in_ts($1)){
                fprintf(stderr,"La constante existe deja 11\n");
                return 1;
            } else {add_symb_var_ts($1,0,INT);}}; 
    |tID tASSIGN Arith_Expr { add_symb_var_ts($1,1, INT); };


Declaration : tINT DecNext tSEMI ;

DecNext : tID tCOMMA DecNext {if (symb_in_ts($1)){
                fprintf(stderr,"La constante existe deja 2\n");
                return 1;
            } else {add_symb_var_ts($1,0,INT);}}
        | tID {if (symb_in_ts($1)){
                fprintf(stderr,"La constante existe deja 22\n");
                return 1;
            } else {add_symb_var_ts($1,0,INT);}}
        | tID tASSIGN Arith_Expr {add_symb_var_ts($1,1, INT); }
        | tID tASSIGN {if (symb_in_ts($1)){
                fprintf(stderr,"La constante existe deja 2222\n");
                return 1;
            } else {add_symb_var_ts($1,0,INT);}} tID tLPAR ArgList tRPAR ; 

Affectation : tID tASSIGN Arith_Expr tSEMI {
                        add_cop(get_addr_var_ts($1)); 
                        add_symb_var_ts($1,1, INT);
                        printf("Apres affectation \n");print_TS_cst();
                        print_tab_asm();
                        printf("Valeur de $1 %s",$1);};
            


LoopIF : tIF tLPAR Condition tRPAR 
      {
            line = add_jump(JMF,0); 
            printf("Ajout JMF"); print_tab_asm();
      } 
      Body 
      { 
            int nb = get_last_line_asm();
            patch(line,nb+2); 
            printf("Apres patch JMF"); print_tab_asm();
            line = add_jump(JMP,0); 
            printf("Ajout JMP"); print_tab_asm();
      }
      IfNext ;

IfNext : tELSE Body 
      {
            int nb = get_last_line_asm(); 
            patch(line,nb+1);
            printf("Apres patch JMP"); print_tab_asm();
      }
      | %empty ;


LoopWHILE : tWHILE tLPAR  Condition tRPAR 
      {
            line = add_jump(JMF,0); 
            printf("Ajout JMF"); print_tab_asm();
      } 
      Body 
      { 
            int nb = get_last_line_asm();
            patch(line,nb+2); 
            printf("Apres patch JMF"); print_tab_asm();
            line = add_jump(JMP,0); 
            printf("Ajout JMP"); print_tab_asm();
      }
; 


Arith_Expr : Factor 
           | Arith_Expr tADD Factor {
           // on genere la fct assembleur correspondante add @res @op1 @op2, on recup les operandes avec la ram, @res variable tempo
                printf("ADD\n");
                add_symb_tmp_ts(); print_TS_tmp();
                add_arithm(ADD);
                print_tab_asm();}
           | Arith_Expr tSUB Factor{
                  printf("SUB\n");
                add_symb_tmp_ts();  print_TS_tmp();
                add_arithm(SUB);
                print_tab_asm();}
            
           //mettre actions simples, printf pour verifier que grammaire est bonne, printf ensuite transforme en fprintf des instructions en asm, il nous faut recuper l @ dans la ts

Factor : Term 
       | Factor tMUL Term
       | Factor tDIV Term ;

Term : tNB {
      printf("tNB\n");
        add_symb_tmp_ts();  print_TS_tmp();
        add_instruc2(AFC, get_last_tmp_addr(), $1); print_tab_asm();
        $$ = $1;
        rmv_symb_ts();  printf(" Apres rmv \n"); print_TS_tmp();
        }
     | tID  {
            printf("tID\n");
        add_symb_tmp_ts();  print_TS_tmp();
        add_instruc2(COP, get_last_tmp_addr(), get_addr_var_ts($1)); print_tab_asm();
        $$ = get_last_tmp_addr();
        rmv_symb_ts();  printf(" Apres rmv \n"); print_TS_tmp();
        }
     | tLPAR Arith_Expr tRPAR;


Condition : Bool_Expr 
          | Bool_Expr tAND Bool_Expr {
             printf("AND\n");
                add_arithm(AND);
                print_tab_asm();
                add_symb_tmp_ts();  print_TS_tmp();
            
          }
          | Bool_Expr tNOT Bool_Expr 
          | Bool_Expr tOR Bool_Expr { 
            printf("OR\n");
                add_arithm(OR);
                print_tab_asm();
                add_symb_tmp_ts();  print_TS_tmp();
          };

Bool_Expr : tTRUE 
          | tFALSE 
          | Arith_Expr tLT Arith_Expr{
                  printf("INF\n");
                add_arithm(INF);
                print_tab_asm();
                add_symb_tmp_ts();  print_TS_tmp();
          }
          | Arith_Expr tGT Arith_Expr {
            printf("SUP\n");
                add_arithm(SUP);
                print_tab_asm();
                add_symb_tmp_ts();  print_TS_tmp();
          }
          | Arith_Expr tGE Arith_Expr
          | Arith_Expr tLE Arith_Expr
          | Arith_Expr tNE Arith_Expr
          | Arith_Expr tEQ Arith_Expr {
            printf("EQU\n");
                add_arithm(EQU);
                print_tab_asm();
                add_symb_tmp_ts();  print_TS_tmp();
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
  deleteTS();
  yyparse();
}
