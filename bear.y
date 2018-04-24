%{

#define C_RED     "\e[1;31m"
#define C_GREEN   "\e[1;32m"
#define C_BLUE    "\e[1;34m"
#define C_YELLOW	"\e[1;33m"
#define C_RST   	"\e[0m"

#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>

extern int		yylex();
extern int		yyparse();
extern FILE*	yyin;
extern int		line_number;

void success_log(const char *, ...);
void warning_log(const char *, ...);
void error_log(const char *, ...);
void yyerror(const char *);

%}

// constants
%token CN_INT
%token CN_FLT
%token CN_ID

// keywords
%token KW_INT
%token KW_FLT
%token KW_IF
%token KW_WHL
%token KW_STR

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

// arithmetic
%token AR_OPR;
%token AR_CPR;

// end of statement
%token EOS;

%start program

%%

program
	:	%empty
	| statement
	| program statement
	;

statement
	: assigment expression EOS
	| if EOS
	| while EOS
	;

assigment
	: int_assigment
	| float_assigment
	;

int_assigment
	: KW_INT CN_ID OP_ASG
	;

float_assigment
	: KW_FLT CN_ID OP_ASG
	;

expression
  : CN_INT
  | CN_FLT
  | CN_ID
  | AR_OPR expression AR_CPR
	| expression OP_ADD expression
	| expression OP_SUB expression
	| expression OP_MUL expression
	| expression OP_DIV expression
	| expression OP_EQ expression
	| expression OP_NEQ expression
	| expression OP_GEQ expression
	| expression OP_LEQ expression
	| expression OP_GTR expression
	| expression OP_LSR expression
	;	

if
	: KW_IF expression EOS program
	;

while
	: KW_WHL expression EOS program
	;


%%

int main(int argc, char **argv) {
	if(!argv[1]) {
		error_log("Input file not provided");
		return -1;
	}

	FILE *input_file = fopen(argv[1], "r");
	if(!input_file) {
		error_log("File "C_BLUE"%s"C_RST" could not be opened", argv[1]);
		return -1;
	}
	yyin = input_file;

	do {
		yyparse();
	} while (!feof(yyin));
	success_log("Parsing completed succesfully");
	return 0;
}

void success_log(const char *message, ...) {
	va_list arglist;
	printf(C_GREEN"[SUCCESS]"C_RST" ");
	va_start(arglist, message);
	vprintf(message, arglist);
	va_end(arglist);
	printf("\n");
}

void warning_log(const char *message, ...) {
	va_list arglist;
	printf(C_YELLOW"[WARNING]"C_RST" ");
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
	error_log("%s on line number "C_BLUE"%i"C_RST, message, line_number);
	exit(-1);
};