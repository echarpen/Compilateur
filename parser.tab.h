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

#ifndef YY_YY_PARSER_TAB_H_INCLUDED
# define YY_YY_PARSER_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 1
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
    tELSE = 261,
    tWHILE = 262,
    tVOID = 263,
    tTRUE = 264,
    tFALSE = 265,
    tLPAR = 266,
    tRPAR = 267,
    tLBRACE = 268,
    tRBRACE = 269,
    tCONST = 270,
    tINT = 271,
    tCOMMA = 272,
    tSEMI = 273,
    tADD = 274,
    tSUB = 275,
    tMUL = 276,
    tDIV = 277,
    tEQ = 278,
    tLT = 279,
    tGT = 280,
    tNE = 281,
    tAND = 282,
    tOR = 283,
    tGE = 284,
    tLE = 285,
    tASSIGN = 286,
    tNOT = 287,
    tCOMMENT = 288,
    tERROR = 289,
    tNB = 290,
    tIF = 291,
    tID = 292
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 14 "parser.y"
 int nb ; char str[16];

#line 98 "parser.tab.h"

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

#line 116 "parser.tab.h"

#endif /* !YY_YY_PARSER_TAB_H_INCLUDED  */
