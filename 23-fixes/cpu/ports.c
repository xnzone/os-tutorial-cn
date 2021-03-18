#include "ports.h"

/**
 * 从指定的端口读取一个byte
 */
uint8_t port_byte_in(uint16_t port) {
    uint8_t result;
    /**
     * 内联汇编语言
     * 注意源和目标寄存器被交换了
     * '"=a" (result)' ; 设置寄存器 e'a'x的值给C语言变量'(result)'
     * '"d" (port)' ; 把寄存器e'd'x和C语言变量'(port)' 匹配
     * 输入和输出是分开的
     */
    asm("in %%dx, %%al" : "=a" (result) : "d" (port));
    return result;
}

void port_byte_out(uint16_t port, uint8_t data) {
    /**
     * 注意这里寄存器和C变量绑定了，没有结果输出。
     * 所以不要再汇编语言里使用 '='
     * 然而我们看代一个逗号，因为有两个变量在输入区，没有变量在返回区
     */
    asm volatile("out %%al, %%dx" : : "a" (data), "d" (port));
}

uint16_t port_word_in (uint16_t port) {
    uint16_t result;
    asm("in %%dx, %%ax" : "=a" (result) : "d" (port));
    return result;
}

void port_word_out (uint16_t port, uint16_t data) {
    asm volatile("out %%ax, %%dx" : : "a" (data), "d" (port));
}
