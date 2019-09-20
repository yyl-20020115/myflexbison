/*calc1-2.l*/
%{
#define YYSTYPE double
#include "calc.tab.h"
#include <stdlib.h>
%}
 
%%
"+"     { return ADD; }
"-"     { return SUB; }
"*"     { return MUL; }
"/"     { return DIV; }
"|"     { return ABS; }
"("     { return OP; }
")"     { return CP; }
([0-9]*\.?[0-9]+|[0-9]+\.)  { yylval = atof(yytext); return NUMBER;}
"sqrt"  { return SQRT; }
"**"    { return SQR; }
"quit"  { return QUIT;}
\n      { return EOL; }
[ \t]   {}
"//".*  {}
%%

int yywrap (void)
{
	return 1;
}
