%start program
%token LET INTEGER IN
%token DO ELSE END FI IF READ SKIP THEN WHILE WRITE

%token NUMBER
%token IDENTIFIER ASSIGNOP

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
int errors;
main(int argc, char* argv[]) {
    extern FILE *yyin;
    ++argv; --argc;
    yyin = fopen(argv[0], 'r');
    yydebug = 1;
    errors = 0;
    yyparse();
}