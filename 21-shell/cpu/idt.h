#ifndef IDT_H
#define IDT_H

#include "types.h"

/* 段选择器 */
#define KERNEL_CS 0x08

/* 每个中断门的定义 */
typedef struct {
    u16 low_offset; /* 处理函数地址的低16位 */
    u16 sel; /* 内核段处理器 */
    u8 always0;
    /* 标志位定义
     * bit 7: 现在中断
     * bit 6-5: 调用者的优先级(0=内核级..3=用户级)
     * bit 4: 中断门设为0
     * bit 3-0: 1110 = decimal。14 = 32位中断门 */
    u8 flags;
    u16 high_offset; /* 处理函数地址的高16位 */
}__attribute__((packed)) idt_gate_t;

/* 指向中断处理数组的指针
 * 汇编结构的 'lidt' 会读到它 */
typedef struct {
    u16 limit;
    u32 base;
}__attribute__((packed)) idt_register_t;

#define IDT_ENTRIES 256
idt_gate_t idt[IDT_ENTRIES];
idt_register_t idt_reg;

/* 在idt.c实现的函数 */
void set_idt_gate(int n, u32 handler);
void set_idt();
#endif