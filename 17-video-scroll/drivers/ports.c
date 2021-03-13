/**
 * 从指定的端口读取一个byte
 */
unsigned char port_byte_in(unsigned short port) {
    unsigned char result;
    /**
     * 内联汇编语言
     * 注意源和目标寄存器被交换了
     * '"=a" (result)' ; 设置寄存器 e'a'x的值给C语言变量'(result)'
     * '"d" (port)' ; 把寄存器e'd'x和C语言变量'(port)' 匹配
     * 输入和输出是分开的
     */
    __asm__("in %%dx, %%al" : "=a" (result) : "d" (port));
    return result;
}

void port_byte_out(unsigned short port, unsigned char data) {
    /**
     * 注意这里寄存器和C变量绑定了，没有结果输出。
     * 所以不要再汇编语言里使用 '='
     * 然而我们看代一个逗号，因为有两个变量在输入区，没有变量在返回区
     */
    __asm__("out %%al, %%dx" : : "a" (data), "d" (port));
}

unsigned short port_word_in(unsigned short port) {
    unsigned short result;
    __asm__("in %%dx, %%ax" : "=a" (result) : "d" (port));
    return result;
}

void port_word_out(unsigned short port, unsigned short data) {
    __asm__("out %%ax, %%dx" : : "a" (data), "d" (port));
}