#ifndef IDT_H
#define IDT_H

#include "types.h"

/* 段选择器 */
#define KERNEL_CS 0x08

/* 每个中断门的定义 */
typedef struct {
    u16 low_offset; /* 处理函数地址的低16位 */
}

#endif