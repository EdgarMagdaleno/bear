%{

#define C_RED     "\033[1;31m"
#define C_GREEN   "\x1b[32m"
#define C_YELLOW  "\x1b[33m"
#define C_BLUE    "\x1b[34m"
#define C_MAGENTA "\x1b[35m"
#define C_CYAN    "\x1b[36m"
#define C_RST   	"\x1b[0m"

#include <stdio.h>
#include <stdlib.h>

extern int yylex();
extern int yyparse();
extern FILE* yyin;

void error_log(const char *);
void yyerror(const char *);

%}

%union {
	int ival;
	float fval;
	char *sval;
}

%token <ival> INT
%token <fval> FLOAT
%token <sval> STRING

%%

snazzle:
	snazzle INT { printf("bison found an int: %i\n", $2); }
	| snazzle FLOAT { printf("bison found a float: %f\n", $2); }
	| snazzle STRING { printf("bison found a string: %s\n", $2); } 
	| INT { printf("bison found an int: %i\n", $1);}
	| FLOAT { printf("bison found a float: %f\n", $1);}
	| STRING { printf("bison found a string: %s\n", $1);}
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
}

void error_log(const char *message) {
	printf(C_RED"[ERROR]"C_RST" %s\n", message);
}

void yyerror(const char *message) {
	printf(C_RED"[ERROR]"C_RST" %s\n", message);
}