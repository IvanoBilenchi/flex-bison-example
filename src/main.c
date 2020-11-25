#include <stdio.h>

#include "lexer.h"
#include "parser.h"

int main(void) {
    char expr[256];
    int ret;

    while (1) {
        fflush(stdin);

        if (!fgets(expr, sizeof(expr), stdin)) {
            continue;
        }

        YY_BUFFER_STATE state = yy_scan_bytes(expr, strcspn(expr, "\n"));

        if (state && yyparse(&ret) == 0) {
            printf("= %d\n", ret);
            yy_delete_buffer(state);
        }
    }

    return 0;
}
