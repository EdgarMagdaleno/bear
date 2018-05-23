all:
	bison -d bear.y -Wnone -Wconflicts-sr -v
	flex bear.l
	gcc bear.tab.c lex.yy.c -lfl -o comp