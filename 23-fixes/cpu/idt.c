#include "idt.h"
#include "type.h"

void set_idt_gate(int n, uint32_t handler) {
    idt[n].low_offset = low_16(handler);
    idt[n].sel = KERNEL_CS;
    idt[n].always0 = 0;
    idt[n].flags = 0x8E;
    idt[n].high_offset = high_16(handler);
}

void set_idt() {
    idt_reg.base = (u32)&idt;
    idt_reg.limit = IDT_ENTRIES * sizeof(idt_gate_t) - 1;
    /* 加载&idt的时候，不要放错误---总是加载&idt_reg */
    asm volatile("lidtl (%0)" : : "r" (&idt_reg));
}
