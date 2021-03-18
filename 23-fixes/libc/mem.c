#include "mem.h"

void memory_copy(uint8_t* src, uint8_t* dest, int nbytes) {
    int i;
    for(i = 0; i < nbytes; i++) {
        *(dest + i) = *(src + i);
    }
}

void memory_set(uint8_t* dest, uint8_t val, uint32_t len) {
    uint8_t* temp = (uint8_t*)dest;
    for(; len != 0; len--){
        *temp++ = val;
    }
}


/* 这应该花费线性时间，但是硬件编码值现在是可以的
 * 记住我们内核在Makefile定义的是从0x1000地址开始的 */
uint32_t free_mem_addr = 0x10000;
/* 实现一个持续增长的指向空闲内存的指针 */
uint32_t kmalloc(size_t size, int align, uint32_t* phys_addr) {
    /* 页对齐为4k或者0x1000 */
    if(align == 1 && (free_mem_addr & 0xFFFFF000)) {
        free_mem_addr &= 0xFFFFF000;
        free_mem_addr += 0x1000;
    }
    /* 保存物理地址 */
    if(phys_addr) *phys_addr = free_mem_addr;

    uint32_t ret = free_mem_addr;
    free_mem_addr += size; /* 记住增长指针 */
    return ret;
}