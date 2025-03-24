%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
void yyerror(const char *s);
int yylex(void);

#define SYMTAB_SIZE 100
typedef struct {
    char *name;
    float value;
} symbol;

symbol symtab[SYMTAB_SIZE];
int symtab_index = 0;

float get_variable(char *name) {
    for (int i = 0; i < symtab_index; i++) {
        if (strcmp(symtab[i].name, name) == 0)
            return symtab[i].value;
    }
    printf("Undefined variable %s. Defaulting to 0.0\n", name);
    return 0.0;
}

void set_variable(char *name, float value) {
    for (int i = 0; i < symtab_index; i++) {
        if (strcmp(symtab[i].name, name) == 0) {
            symtab[i].value = value;
            return;
        }
    }
    symtab[symtab_index].name = strdup(name);
    symtab[symtab_index].value = value;
    symtab_index++;
}
%}


%union {
    float fval;
    char *id;
}


%token <fval> NUMBER
%token PLUS MINUS TIMES DIVIDE LPAREN RPAREN EQUAL POWER
%token <id> ID

%type <fval> expr stmt

%left PLUS MINUS
%left TIMES DIVIDE
%right POWER


%%

input:
      /* empty */
    | input line
    ;

line:
    '\n'
  | stmt '\n' {
      if (!isnan($1)) {
        printf("Result: %.4f\n", $1);
      }
    }
  ;


stmt:
      expr              { $$ = $1; }
    | ID EQUAL expr     { set_variable($1, $3); $$ = $3; free($1); }
    ;

expr:
      expr PLUS expr    { $$ = $1 + $3; }
    | expr MINUS expr   { $$ = $1 - $3; }
    | expr TIMES expr   { $$ = $1 * $3; }
    | expr DIVIDE expr  {
                          if ($3 == 0.0) {
                              yyerror("Division by zero");
                              $$ = NAN;
                          } else {
                              $$ = $1 / $3;
                          }
                        }
    | expr POWER expr   { $$ = pow($1, $3); }
    | LPAREN expr RPAREN { $$ = $2; }
    | NUMBER            { $$ = $1; }
    | ID                { $$ = get_variable($1); free($1); }
    ;


%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main(void) {
    printf("Simple Calculator for 395HW_1. Enter expressions or assignments:\n");
    return yyparse();
}
