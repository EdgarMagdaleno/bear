%{

#include <stdio.h>
#include "bear.tab.h"

int line_number = 1;

%}

%%

"int"										return KW_INT;
"float"									return KW_FLOAT;
";"											return EOS;
"=="										return OP_CMP;
"+"											return OP_ADD;
"-"											return OP_SUB;
"*"											return OP_MUL;
"/"											return OP_DIV;
"="											return OP_ASG;
[0-9]+\.[0-9]+  				{ yylval.float_value = atof(yytext); return CN_FLOAT; }
[0-9]+          				{ yylval.integer_value = atoi(yytext); return CN_INT; }
[_a-zA-Z][_a-zA-Z0-9]*	{ yylval.string_value = strdup(yytext); return CN_ID; }
\n											{ line_number++; }
[ \r\t]+ 								;

%%