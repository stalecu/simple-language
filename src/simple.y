%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "./ST.h"
#include "./SM.h"
int errors;
#define YYDEBUG 1

install(char *sym_name) {
    symrec *s;
    s = getsym(sym_name);
    if (s == 0) {
        s = putsym(sym_name);
    }
    else {
        errors++;
        printf("%s already defined!\n", sym_name);
    }
}

context_check(char *sym_name) {
    if (getsym(sym_name) == 0) {
        printf("Undeclared identifier: %s\n", sym_name);
    }
}

%}

%union {
    char* id;
}

%start program
%token NUMBER
%token <id> IDENTIFIER
%token IF WHILE
%token LET INTEGER IN
%token SKIP THEN ELSE FI DO END
%token READ WRITE
%token ASSIGNOP

%left '-' '+'
%left '*' '/'
%right '^'
%%
program: LET declarations IN commands END ;

declarations: /* empty */
            | INTEGER id_seq IDENTIFIER '.' { install($3); }
;

id_seq: /* empty */
      | id_seq IDENTIFIER ',' { install($2); }
;

commands: /* empty */
        | commands command ';'
;

command: SKIP
       | READ IDENTIFIER { context_check($2); }
       | WRITE exp
       | IDENTIFIER ASSIGNOP exp { context_check($1); }
       | IF exp THEN commands ELSE commands FI
       | WHILE exp DO commands END
;

exp: NUMBER
   | IDENTIFIER { context_check($2); }
   | exp '<' exp
   | exp '>' exp
   | exp '=' exp
   | exp '+' exp
   | exp '-' exp
   | exp '*' exp
   | exp '/' exp
   | exp '^' exp
   | '(' exp ')'
;
%%

main(int argc, char* argv[]) {
    extern FILE *yyin;
    ++argv; --argc;
    yyin = fopen(argv[0], "r");
    errors = 0;
    yyparse();

    printf("Parse completed!\n");
    if (errors == 0) {
        print_code();
        fetch_execute_cycle();
    }
}
yyerror(char *s) {
    errors++;
    printf("%s\n", s);
}