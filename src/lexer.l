%option noyywrap

%top {
    #include "parser.h"
}

INTEGER [0-9]+

%%

"+" { return PLUS; }
"-" { return MINUS; }
"*" { return TIMES; }
"(" { return LPAREN; }
")" { return RPAREN; }

{INTEGER} {
    yylval = atoi(yytext);
    return NUMBER;
}

. ;
