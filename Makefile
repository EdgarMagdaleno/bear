all:
	bison -d bear.y
	flex bear.l
	gcc bear.tab.c lex.yy.c -lfl -o comp