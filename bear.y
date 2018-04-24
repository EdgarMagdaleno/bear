%{

#define C_RED     "\033[1;31m"
#define C_GREEN   "\033[32;1m"
#define C_BLUE    "\033[1;34m"
#define C_RST   	"\x1b[0m"

#include <stdio.h>
#include <stdlib.h>

extern int yylex();
extern int yyparse();
extern FILE* yyin;
extern int line_number;

void error_log(const char *);
void yyerror(const char *);

%}

%union {
	int integer_value;
	float float_value;
	char *string_value;
}

// constants
%token <integer_value> CN_INT
%token <float_value> CN_FLOAT
%token <string_value> CN_ID

// keywords
%token KW_INT
%token KW_FLOAT

// operators
%token OP_CMP;
%token OP_ASG;
%token OP_ADD;
%token OP_SUB;
%token OP_MUL;
%token OP_DIV;

// end of statement
%token EOS;

%start program

%%

program:
	KW_INT CN_ID OP_ASG CN_INT EOS
	;
%%

int main(int argc, char **argv) {
	if(!argv[1]) {
		error_log("Input file not provided");
		return -1;
	}

	FILE *input_file = fopen(argv[1], "r");
	if(!input_file) {
		printf(C_RED"[ERROR]"C_RST" File "C_BLUE"%s"C_RST" could not be opened\n", argv[1]);
		return -1;
	}
	yyin = input_file;

	do {
		yyparse();
	} while (!feof(yyin));
	printf(C_GREEN"[SUCCESS]"C_RST" Parsing completed succesfully\n");
	return 0;
}

void error_log(const char *message) {
	printf(C_RED"[ERROR]"C_RST" %s\n", message);
}

void yyerror(const char *message) {
	printf(C_RED"[ERROR]"C_RST" %s on line number "C_BLUE"%i"C_RST"\n", message, line_number);
}