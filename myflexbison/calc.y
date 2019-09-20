/* calc1-2.y*/
%{
#define YYSTYPE double
#include<stdio.h>
#include<math.h>
extern int yylex (void);
extern int yywrap ( void );

int yyerror(const char *s);
%}
 
%token NUMBER
%token ADD SUB MUL DIV ABS
%token EOL
%token OP CP
%token SQR SQRT
%token QUIT
 
%%
 
calclist:
    | calclist exp EOL { printf("ans = %f\n>>> " ,$2 );  }
    ;
 
exp: factor { $$ = $1; }
    | exp ADD factor { $$ = $1 + $3 ; }
    | exp SUB factor { $$ = $1 - $3 ; }
    ;
factor: tmp { $$ =$1; }
    | factor MUL tmp { $$ = $1 * $3; }
    | factor DIV tmp { $$ = $1 / $3; }
    ;
tmp: term { $$ = $1; }
    | SUB tmp { $$ = -$2; }
    | tmp SQR tmp { $$ = pow($1,$3);  /*printf("%d %d %d\n",$1,$2,$3);*/}
    ;
 
term: NUMBER { $$ = $1;}
    | ABS exp ABS { $$ = fabs($2);}
    | OP exp CP { $$ = $2; }
    | SQRT OP exp CP { $$ = sqrt($3) ;/*printf(" %d %d %d\n",$1,$2,$3);*/ }
	| QUIT EOL { exit(0); }
    ;

%%
 
int main()
{
    printf(">>> ");
    while(1)
        yyparse();
    return 0;
}
int yyerror(const char *s)
{
    fprintf(stderr,"error : %s\n",s);
	return 0;
}
