%{
    #include "./simple.tab.h"    
%}
DIGIT   [0-9]
ID      [a-z][a-z0-9]*
%%

":="     { return(ASSIGNOP);    }
{DIGIT}+ { return(NUMBER);      }
do       { return(DO);          }
else     { return(ELSE);        }
end      { return(END);         }
fi       { return(FI);          }
if       { return(IF);          }
in       { return(IN);          }
integer  { return(INTEGER);     }
let      { return(LET);         }
read     { return(READ);        }
skip     { return(SKIP);        }
then     { return(THEN);        }
while    { return(WHILE);       }
write    { return(WRITE);       }
{ID}     { return(IDENTIFIER);  }
[ \t\n]+ /* Consume all spaces, tabs and newlines. */
.        { return(yytext[0]);   }
%%