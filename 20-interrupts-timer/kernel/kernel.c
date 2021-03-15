#include "../drivers/screen.h"
#include "util.h"
#include "../cpu/isr.h"
#include "../cpu/idt.h"
#include "../drivers/keyboard.h"

void main() {
    isr_install();
    asm volatile("sti");
    init_timer(50);
    /* 键盘IRQs更简单 */
    init_keyboard();
}
