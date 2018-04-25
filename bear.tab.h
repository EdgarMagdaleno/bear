/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

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

#ifndef YY_YY_BEAR_TAB_H_INCLUDED
# define YY_YY_BEAR_TAB_H_INCLUDED
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
    SX_EOS = 258,
    SX_PNT = 259,
    SX_CLN = 260,
    SX_CMA = 261,
    SX_OPR = 262,
    SX_CPR = 263,
    SX_ARR = 264,
    CN_INT = 265,
    CN_FLT = 266,
    CN_ID = 267,
    CN_STR = 268,
    KW_INT = 269,
    KW_FLT = 270,
    KW_IF = 271,
    KW_FOR = 272,
    KW_EIF = 273,
    KW_ELS = 274,
    KW_WHL = 275,
    KW_STR = 276,
    KW_FNC = 277,
    KW_OUT = 278,
    OP_EQ = 279,
    OP_NEQ = 280,
    OP_GEQ = 281,
    OP_LEQ = 282,
    OP_GTR = 283,
    OP_LSR = 284,
    OP_ASG = 285,
    OP_ADD = 286,
    OP_SUB = 287,
    OP_MUL = 288,
    OP_DIV = 289
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_BEAR_TAB_H_INCLUDED  */
