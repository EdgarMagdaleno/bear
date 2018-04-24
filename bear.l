D			[0-9]
L			[a-zA-Z_]
H			[a-fA-F0-9]
E			[Ee][+-]?{D}+
FS		(f|F|l|L)
IS		(u|U|l|L)*

%{

#include <stdio.h>
#include "bear.tab.h"

int line_number = 1;

%}

%%

";"											return EOS;
"if"										return KW_IF;
"while"									return KW_WHL;
"int"										return KW_INT;
"float"									return KW_FLT;
"string"								return KW_STR;
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
"("											return AR_OPR;
")"											return AR_CPR;
[0-9]+\.[0-9]+  				return CN_FLT;
[0-9]+          				return CN_INT;
[_a-zA-Z][_a-zA-Z0-9]*	return CN_ID;
\n											line_number++;
[ \r\t]+ 								;
.												;

%%