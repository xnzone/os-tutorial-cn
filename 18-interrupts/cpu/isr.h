#ifndef ISR_H
#define ISR_H

#include "types.h"

/* ISRs reserved for CPU exceptions */
extern void isr0();
extern void isr1();
extern void isr2();
extern void isr3();
extern void isr4();
extern void isr5();
extern void isr6();
extern void isr7();
extern void isr8();
extern void isr9();
extern void isr10();
extern void isr11();
extern void isr12();
extern void isr13();
extern void isr14();
extern void isr15();
extern void isr16();
extern void isr17();
extern void isr18();
extern void isr19();
extern void isr20();
extern void isr21();
extern void isr22();
extern void isr23();
extern void isr24();
extern void isr25();
extern void isr26();
extern void isr27();
extern void isr28();
extern void isr29();
extern void isr30();
extern void isr31();

/* 组合很多寄存器的结构体 */
typedef struct {
    u32 ds; /* 数据段选择器 */
    u32 edi, esi, ebp, esp, ebx, edx, ecx, eax; /* pushed by pusha */
    u32 int_no, err_code; /* 中断号和错误码(如果有的话) */
    u32 eip, cs, eflags, useresp, ss; /* pushed by processor automaticall */
} register_t;


void isr_install();
void isr_handler(register_t r);

#endif