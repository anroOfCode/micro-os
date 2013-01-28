#include <stdio.h>

#undef putchar

module PutcharP {
    provides interface Init;
    uses interface Putchar;
} implementation {

    command error_t Init.init() {
        error_t rv = SUCCESS;
        return rv;
    }

    int putchar(int c) __attribute__((noinline)) @C() @spontaneous() {
        return call Putchar.putchar (c);
    }
}
