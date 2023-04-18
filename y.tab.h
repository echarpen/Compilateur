/* A Bison parser, made by GNU Bison 3.5.1.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2020 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* Undocumented macros, especially those whose name start with YY_,
   are private implementation details.  Do not rely on them.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    tMAIN = 258,
    tPRINTF = 259,
    tRETURN = 260,
    tIF = 261,
    tELSE = 262,
    tWHILE = 263,
    tVOID = 264,
    tTRUE = 265,
    tFALSE = 266,
    tLPAR = 267,
    tRPAR = 268,
    tLBRACE = 269,
    tRBRACE = 270,
    tCONST = 271,
    tINT = 272,
    tCOMMA = 273,
    tSEMI = 274,
    tADD = 275,
    tSUB = 276,
    tMUL = 277,
    tDIV = 278,
    tEQ = 279,
    tLT = 280,
    tGT = 281,
    tNE = 282,
    tAND = 283,
    tOR = 284,
    tGE = 285,
    tLE = 286,
    tASSIGN = 287,
    tNOT = 288,
    tCOMMENT = 289,
    tERROR = 290,
    tNB = 291,
    tID = 292
  };
#endif
/* Tokens.  */
#define tMAIN 258
#define tPRINTF 259
#define tRETURN 260
#define tIF 261
#define tELSE 262
#define tWHILE 263
#define tVOID 264
#define tTRUE 265
#define tFALSE 266
#define tLPAR 267
#define tRPAR 268
#define tLBRACE 269
#define tRBRACE 270
#define tCONST 271
#define tINT 272
#define tCOMMA 273
#define tSEMI 274
#define tADD 275
#define tSUB 276
#define tMUL 277
#define tDIV 278
#define tEQ 279
#define tLT 280
#define tGT 281
#define tNE 282
#define tAND 283
#define tOR 284
#define tGE 285
#define tLE 286
#define tASSIGN 287
#define tNOT 288
#define tCOMMENT 289
#define tERROR 290
#define tNB 291
#define tID 292

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 14 "parser.y"
 int nb ; char str[16];

#line 134 "y.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);
/* "%code provides" blocks.  */
#line 9 "parser.y"

    int yylex(void);
    void yyerror(const char*);

#line 152 "y.tab.h"

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
