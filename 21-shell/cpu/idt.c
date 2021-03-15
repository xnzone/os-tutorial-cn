#include "idt.h"
#include "../kernel/util.h"

void set_idt_gate(int n, u32 handler) {
    idt[n].low_offset = low_16(handler);
    idt[n].sel = KERNEL_CS;
    idt[n].always0 = 0;
    idt[n].flags = 0x8E;
    idt[n].high_offset = hight_16(handler);
}


void set_idt() {
    idt_reg.base = (u32)&idt;
    idt_reg.limit = IDT_ENTRIES * sizeof(idt_gate_t) - 1;
    /* 加载&idt的时候，不要放错误---总是加载&idt_reg */
    __asm__ __volatile__("lidtl (%0)" : : "r" (&idt_reg));
}