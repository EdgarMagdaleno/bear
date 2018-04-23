%{

#include <stdio.h>

extern int yylex();
extern int yyparse();
extern FILE* yyin;

void yyerror(const char* s);
void exit(int exit_code);

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
	INT snazzle      { printf("bison found an int: %s\n", $1); }
	| FLOAT snazzle  { printf("bison found a float: %s\n", $1); }
	| STRING snazzle { printf("bison found a string: %s\n", $1); }
	| INT            { printf("bison found an int: %s\n", $1); }
	| FLOAT          { printf("bison found a float: %s\n", $1); }
	| STRING         { printf("bison found a string: %s\n", $1); }
	;

%%

int main(int argc, char **argv) {
	FILE *input_file = fopen(argv[1], "r");
	if(!input_file) {
		printf("[ERROR] File \"%s\" could not be opened\n", argv[1]);
		return -1;
	}
	yyin = input_file;

	do {
		yyparse();
	} while (!feof(yyin));
}

void yyerror(const char *s) {
	printf("Error: %s", s);
	exit(-1);
}