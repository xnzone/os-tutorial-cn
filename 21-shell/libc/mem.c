#include "mem.h"

void memory_copy(u8* src, u8* dest, int nbytes) {
    int i;
    for(i = 0; i < nbytes; i++) {
        *(dest + i) = *(src + i);
    }
}

void memory_set(u8* dest, u8 val, u32 len) {
    u8* temp = (u8*)dest;
    for(; len != 0; len--){
        *temp++ = val;
    }
}