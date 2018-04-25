%{

#define C_RED	"\e[1;31m"
#define C_GRN	"\e[1;32m"
#define C_BLU	"\e[1;34m"
#define C_YLW	"\e[1;33m"
#define C_RST "\e[0m"

#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>

extern int		yylex();
extern int		yyparse();
extern FILE*	yyin;
extern int		line_number;

char found_error = 0;

void success_log(const char *, ...);
void warning_log(const char *, ...);
void error_log(const char *, ...);
void yyerror(const char *);

%}

// syntax
%token SX_EOS
%token SX_PNT
%token SX_CLN
%token SX_CMA
%token SX_OPR;
%token SX_CPR;

// constants
%token CN_INT
%token CN_FLT
%token CN_ID

// keywords
%token KW_INT
%token KW_FLT
%token KW_IF
%token KW_EIF
%token KW_ELS
%token KW_WHL
%token KW_STR
%token KW_FNC
%token KW_OUT

// operators
%token OP_EQ;
%token OP_NEQ;
%token OP_GEQ;
%token OP_LEQ;
%token OP_GTR;
%token OP_LSR;
%token OP_ASG;
%token OP_ADD;
%token OP_SUB;
%token OP_MUL;
%token OP_DIV;

%start program

%%

program
	:	%empty
	| stmnt SX_EOS
	| program stmnt SX_EOS
	| error
	;

type
	:	KW_INT
	| KW_FLT
	;

out
	:	KW_OUT exp
	;

stmnt
	: dec 
	| asgn
	| mod
	| if
	| while
	| out
	;

dec
	: type CN_ID
	;

asgn
	: dec asgn
	| func_dec func_asgn
	;

asgn
	: OP_ASG exp
	;

func_dec
	: dec
	|	type arg_dec CN_ID
	;

func_asgn
	: SX_CLN program
	;

arg_dec
	:	SX_OPR arg_list SX_CPR
	;

arg_list
	:	%empty
	| dec
	| dec SX_CMA arg_list
	;

mod
	: CN_ID OP_ASG exp
	;

exp
	: CN_INT
	| CN_FLT
	| CN_ID
	| SX_OPR exp SX_CPR
	| exp OP_ADD exp
	| exp OP_SUB exp
	| exp OP_MUL exp
	| exp OP_DIV exp
	| exp OP_EQ exp
	| exp OP_NEQ exp
	| exp OP_GEQ exp
	| exp OP_LEQ exp
	| exp OP_GTR exp
	| exp OP_LSR exp
	;	

if
	: if_single
	| if_single eif_list
	| if_single eif_list else
	| if_single else
	;

if_single
	:	KW_IF exp SX_CLN program
	;

eif_list
	:	KW_EIF exp SX_CLN program
	| KW_EIF exp SX_CLN program eif_list
	;

else
	:	KW_ELS SX_CLN program
	;

while
	: KW_WHL exp SX_CLN program
	;

%%

int main(int argc, char **argv) {
	if(!argv[1]) {
		error_log("Input file not provided");
		return -1;
	}

	FILE *input_file = fopen(argv[1], "r");
	if(!input_file) {
		error_log("File "C_BLU"%s"C_RST" could not be opened", argv[1]);
		return -1;
	}
	yyin = input_file;

	do {
		yyparse();
	} while (!feof(yyin));

	if(!found_error) {
		success_log("Parsing completed succesfully");
	}

	return 0;
}

void success_log(const char *message, ...) {
	va_list arglist;
	printf(C_GRN"[SUCCESS]"C_RST" ");
	va_start(arglist, message);
	vprintf(message, arglist);
	va_end(arglist);
	printf("\n");
}

void warning_log(const char *message, ...) {
	va_list arglist;
	printf(C_YLW"[WARNING]"C_RST" ");
	va_start(arglist, message);
	vprintf(message, arglist);
	va_end(arglist);
	printf("\n");
}

void error_log(const char *message, ...) {
	va_list arglist;
	printf(C_RED"[ERROR]"C_RST" ");
	va_start(arglist, message);
	vprintf(message, arglist);
	va_end(arglist);
	printf("\n");
}

void yyerror(const char *message) {
	found_error = 1;
	error_log("%s on line number "C_BLU"%i"C_RST, message, line_number);
};