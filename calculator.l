%{
#include "calculator.tab.h"
#include <stdlib.h>
#include <stdio.h>
%}

%%

[0-9]+"."[0-9]+     { yylval.fval = atof(yytext); return NUMBER; }
[0-9]+              { yylval.fval = atof(yytext); return NUMBER; } // her seyi float olarak hallediyor
"+"                 { return PLUS; }
"-"                 { return MINUS; }
"*"                 { return TIMES; }
"/"                 { return DIVIDE; }
"("                 { return LPAREN; }
")"                 { return RPAREN; }
"^"                 { return POWER; }
[ \t]               { /* ignore spaces */ }
\n                  { return '\n'; }

.                   { printf("Invalid character: %s\n", yytext); }

%%
int yywrap(void) { 
    return 1; }
