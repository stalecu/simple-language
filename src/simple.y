%{
    #include <stdio.h>
    int errors;
    #define YYDEBUG 1
%}

%start program
%token NUMBER
%token IDENTIFIER
%token IF WHILE
%token LET INTEGER IN
%token SKIP THEN ELSE FI DO END
%token INTEGER READ WRITE LET IN
%token ASSIGNOP

%left '-' '+'
%left '*' '/'
%right '^'
%%
program: LET declarations IN commands END ;

declarations: /* empty */
            | INTEGER id_seq IDENTIFIER '.'
;

id_seq: /* empty */
      | id_seq IDENTIFIER ','
;

commands: /* empty */
        | commands command ';'
;

command: SKIP
       | READ IDENTIFIER
       | WRITE exp
       | IDENTIFIER ASSIGNOP exp
       | IF exp THEN commands ELSE commands FI
       | WHILE exp DO commands END
;

exp: NUMBER
   | IDENTIFIER 
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

    printf("Parse completed!");
    if (errors == 0) {
        printf("Syntactically valid!");
    }
}
yyerror(char *s) {
    errors++;
    printf("%s\n", s);
}