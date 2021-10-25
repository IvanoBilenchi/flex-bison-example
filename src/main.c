#include <stdio.h>

#include "lexer.h"
#include "parser.h"

int main(void) {
    while (1) {
        fflush(stdin);
        char expr[256];

        if (!fgets(expr, sizeof(expr), stdin)) {
            continue;
        }

        YY_BUFFER_STATE state;

        if (!(state = yy_scan_bytes(expr, strcspn(expr, "\n")))) {
            continue;
        }

        int ret;

        if (yyparse(&ret) == 0) {
            printf("= %d\n", ret);
        }

        yy_delete_buffer(state);
    }

    return 0;
}
