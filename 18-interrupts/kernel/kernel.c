#include "../drivers/screen.h"
#include "util.h"
#include "../cpu/isr.h"
#include "../cpu/idt.h"

void main() {
    isr_install();
    /* 测试中断 */
    __asm__ __volatile__("int $2");
    __asm__ __volatile__("int $3");
}