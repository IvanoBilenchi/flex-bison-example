%define api.value.type {int}
%parse-param {int *ret}

%code top {
    #include <stdio.h>

    extern int yylex(void);

    static void yyerror(int *ret, const char* s) {
        fprintf(stderr, "%s\n", s);
    }
}

// Terminals

%token NUMBER PLUS MINUS TIMES UMINUS LPAREN RPAREN

// Precedence and associativity

%left PLUS MINUS
%left TIMES
%left UMINUS

%%

// Grammar rules

start
    : expr {
        *ret = $1;
    }
;

expr
    : expr PLUS expr {
        $$ = $1 + $3;
    }
    | expr MINUS expr {
        $$ = $1 - $3;
    }
    | expr TIMES expr {
        $$ = $1 * $3;
    }
    | MINUS expr %prec UMINUS {
        $$ = -$2;
    }
    | LPAREN expr RPAREN {
        $$ = $2;
    }
    | NUMBER {
        $$ = $1;
    }
;
