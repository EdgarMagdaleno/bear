L			[a-zA-Z_]

%{

#include <stdio.h>
#include "bear.tab.h"

int line_number = 1;

%}

%%

";"											return SX_EOS;
"."											return SX_PNT;
","											return SX_CMA;
":"											return SX_CLN;
"[]"										return SX_ARR;
"func"									return KW_FNC;
"out"										return KW_OUT;
"else if"								return KW_EIF;
"if"										return KW_IF;
"else"									return KW_ELS;
"while"									return KW_WHL;
"int"										return KW_INT;
"float"									return KW_FLT;
"string"								return KW_STR;
"for"										return KW_FOR;
L?\"(\\.|[^\\"\n])*\"   return CN_STR;
"=="										return OP_EQ;
"!="										return OP_NEQ;
">="										return OP_GEQ;
"<="										return OP_LEQ;
">"											return OP_GTR;
"<"											return OP_LSR;
"+"											return OP_ADD;
"-"											return OP_SUB;
"*"											return OP_MUL;
"/"											return OP_DIV;
"="											return OP_ASG;
"("											return SX_OPR;
")"											return SX_CPR;
[0-9]+\.[0-9]+  				return CN_FLT;
[0-9]+          				return CN_INT;
[_a-zA-Z][_a-zA-Z0-9]*	return CN_ID;
\n											line_number++;
[ \r\t]+ 								;
.												;

%%