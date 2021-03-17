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


/* 这应该花费线性时间，但是硬件编码值现在是可以的
 * 记住我们内核在Makefile定义的是从0x1000地址开始的 */
u32 free_mem_addr = 0x10000;
/* 实现一个持续增长的指向空闲内存的指针 */
u32 kmalloc(u32 size, int align, u32* phys_addr) {
    /* 页对齐为4k或者0x1000 */
    if(align == 1 && (free_mem_addr & 0xFFFFF000)) {
        free_mem_addr &= 0xFFFFF000;
        free_mem_addr += 0x1000;
    }
    /* 保存物理地址 */
    if(phys_addr) *phys_addr = free_mem_addr;

    u32 ret = free_mem_addr;
    free_mem_addr += size; /* 记住增长指针 */
    return ret;
}