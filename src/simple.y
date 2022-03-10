%start program
%token LET INTEGER IN
%token DO ELSE END FI IF READ SKIP THEN WHILE WRITE

%token NUMBER
%token IDENTIFIER ASSIGNOP

%left '-' '+'
%left '*' '/'
%right '^'