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
%type <nb> Term Condition Bool_Expr Arith_Expr Factor


%%

Program :  {printf("Je rentre dans Program \n");} Function tVOID tMAIN tLPAR tVOID tRPAR Body {asm_save_table();} ;

Function : {printf("Je rentre dans Fct \n");} tINT tID tLPAR ArgList tRPAR Body {}; //enlever apres test save table

ArgList : ArgListNext ;
        | %empty ;

ArgListNext : tINT tID ArgListNextNext 
            | Arith_Expr ArgListNextNext ;

ArgListNextNext : tCOMMA tINT tID ArgListNextNext
                | tCOMMA Arith_Expr ArgListNextNext  
                | %empty ;

Body : tLBRACE Content tRBRACE ;

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
            } else { add_symb_var_ts($1,0,INT);print_TS_cst();}};
    |tID {if (symb_in_ts($1)){
                fprintf(stderr,"La constante existe deja 11\n");
                return 1;
            } else {add_symb_var_ts($1,0,INT);print_TS_cst();}}; 
    |tID tASSIGN Arith_Expr { add_symb_var_ts($1,1, INT); };


// DECLARATIONS int a = ...
Declaration : {printf("Je rentre dans Declaration \n");} tINT DecNext tSEMI ;

DecNext : tID tCOMMA DecNext {if (symb_in_ts($1)){
                fprintf(stderr,"La constante existe deja 2\n");
                return 1;
            } else {add_symb_var_ts($1,0,INT);print_TS_cst();}}
        | tID {if (symb_in_ts($1)){
                fprintf(stderr,"La constante existe deja 22\n");
                return 1;
            } else {add_symb_var_ts($1,0,INT);print_TS_cst();}}
        | tID tASSIGN Arith_Expr {
            if (symb_in_ts($1)){
             fprintf(stderr,"Erreur \n");
                return 1;
            } else {
                  rmv_symb_tmp_ts(1);
                  add_symb_var_ts($1,1,INT);
                  print_TS_cst();
                  print_tab_asm();
                  //add_cop(get_addr_var_ts($1)); 
            }}
            
        | tID tASSIGN  {
            if (symb_in_ts($1)){
                fprintf(stderr,"Erreur \n");
                return 1;
            } else {add_symb_var_ts($1,0,INT);print_TS_cst();}
            } tID tLPAR ArgList tRPAR ; 


//AFFECTATION a = ...
Affectation : tID tASSIGN Arith_Expr tSEMI {
                  if (symb_in_ts($1)){
                        rmv_symb_tmp_ts(1);
                       ts_init($1); print_TS_cst();
                        add_cop_bis(get_addr_var_ts($1), $3);  print_tab_asm();
                  } else {
                        fprintf(stderr,"Erreur la variable n'est pas déclarée \n");
                  } };


            


LoopIF : tIF tLPAR Condition tRPAR 
      {
            increase_scope_ts();
            line = add_jump(JMF,$3,0); 
            printf("Ajout JMF"); print_tab_asm();
      } 
      Body 
      { 
            int nb = get_last_line_asm();
            patch_JMF(line,nb+2); 
            printf("Apres patch JMF"); print_tab_asm();
            line = add_jump(JMP,get_last_line_asm()+2,-1); 
            printf("Ajout JMP"); print_tab_asm();
            decrease_scope_ts();
      }
      IfNext ;

IfNext : tELSE {increase_scope_ts();} Body 
      {
            int nb = get_last_line_asm(); 
            patch_JMP(line,nb+1);
            printf("Apres patch JMP"); print_tab_asm();
            decrease_scope_ts();
      }
      | %empty ;


LoopWHILE : tWHILE tLPAR  Condition tRPAR 
      {
            increase_scope_ts();
            line = add_jump(JMF,$3,0); 
            printf("Ajout JMF"); print_tab_asm();
      } 
      Body 
      { 
            int nb = get_last_line_asm();
            patch_JMF(line,nb+2); 
            printf("Apres patch JMF"); print_tab_asm();
            line = add_jump(JMP,get_last_line_asm()+2,-1); 
            printf("Ajout JMP"); print_tab_asm();
            decrease_scope_ts();
      }
; 


Arith_Expr : Factor {
                  $$ = $1;
                  }
           | Arith_Expr tADD Factor {
           // on genere la fct assembleur correspondante add @res @op1 @op2, on recup les operandes avec la ram, @res variable tempo
                printf("ADD\n");
                print_TS_tmp();
                add_arithm(ADD);
                $$ = get_last_tmp_addr();
                //rmv_symb_tmp_ts(1);
                print_tab_asm();}
           | Arith_Expr tSUB Factor{
                printf("SUB\n");
                print_TS_tmp();
                add_arithm(SUB);
                $$ = get_last_tmp_addr();
                //rmv_symb_tmp_ts(1);
                print_tab_asm();}
            
           //mettre actions simples, printf pour verifier que grammaire est bonne, printf ensuite transforme en fprintf des instructions en asm, il nous faut recuper l @ dans la ts

Factor : Term { $$ = $1; }
       | Factor tMUL Term {
                print_TS_tmp();
                add_arithm(MUL);
                $$ = get_last_tmp_addr();
                print_tab_asm();}
       | Factor tDIV Term {
                print_TS_tmp();
                add_arithm(DIV);
                $$ = get_last_tmp_addr();
                print_tab_asm();};

Term : tNB {
      printf("tNB\n");
        add_symb_tmp_ts();  print_TS_tmp();
        add_instruc2(AFC, get_last_tmp_addr(), $1); print_tab_asm();
        $$ = get_last_tmp_addr();
        }
     | tID  {
        printf("tID\n");
        add_symb_tmp_ts();  print_TS_tmp();
        add_instruc2(COP, get_last_tmp_addr(), get_addr_var_ts($1)); print_tab_asm();
        $$ = get_last_tmp_addr();
        }
     | tLPAR Arith_Expr tRPAR
      { $$ = $2;  }
     ;


Condition : Bool_Expr  {$$ = $1;}
          | Bool_Expr tAND Bool_Expr {
             printf("AND\n");
             rmv_symb_tmp_ts(1);
            add_symb_tmp_ts();  print_TS_tmp();
                add_arithm(AND);
                print_tab_asm();
                //add_symb_tmp_ts();  print_TS_tmp();
                 $$ = get_last_tmp_addr();
            
          }
          | Bool_Expr tNOT Bool_Expr 
          | Bool_Expr tOR Bool_Expr { 
            printf("OR\n");
            rmv_symb_tmp_ts(1);
           add_symb_tmp_ts();  print_TS_tmp();
                add_arithm(OR);
                print_tab_asm();
                //add_symb_tmp_ts();  print_TS_tmp();
                  $$ = get_last_tmp_addr();
          };

Bool_Expr : tTRUE {$$=1;}
          | tFALSE {$$=0;}
          | Arith_Expr tLT Arith_Expr{
            rmv_symb_tmp_ts(1);
                  printf("INF\n");
                  
                  add_symb_tmp_ts();  print_TS_tmp();
                add_arithm(INF);
                $$ = get_last_tmp_addr();
                print_tab_asm();
               
          }
          | Arith_Expr tGT Arith_Expr {
            rmv_symb_tmp_ts(1);
            printf("SUP\n");
            add_symb_tmp_ts();  print_TS_tmp();
                add_arithm(SUP);
                $$ = get_last_tmp_addr();
                print_tab_asm();
                //add_symb_tmp_ts();  print_TS_tmp();
          }
          | Arith_Expr tGE Arith_Expr
          | Arith_Expr tLE Arith_Expr
          | Arith_Expr tNE Arith_Expr
          | Arith_Expr tEQ Arith_Expr {
            rmv_symb_tmp_ts(1);
            printf("EQU\n");
            add_symb_tmp_ts();  print_TS_tmp();
                add_arithm(EQU);
                $$ = get_last_tmp_addr();
                print_tab_asm();
                //add_symb_tmp_ts();  print_TS_tmp();
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
