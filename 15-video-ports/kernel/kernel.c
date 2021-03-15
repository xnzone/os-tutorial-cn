#include "../drivers/ports.h"

void main() {
    /**
     * 屏幕光标位置：像VGA控制寄存器 (0x3d4)查询字节
     * 14 = 光标高位字节 15 = 光标低位字节
     */
    port_byte_out(0x3d4, 14);
    /* VGA数据寄存器（0x3d5)返回的数据 */
    int position = port_byte_in(0x3d5);
    position = position << 8; /* 高位字节 */
     
    port_byte_out(0x3d4, 15); /* 请求低字节 */
    position += port_byte_in(0x3d5);

    /**
     * VGA 'cells' 字符和控制数据是连续的
     * 例如 'white on black background', 'red text on white bg', 等等 
     */
    int offset_from_vga = position * 2;

    /**
     * 现在，你可以用gdb测试所有变量，因为我们仍然不知道怎么打印字符串到屏幕上
     * 运行 'make debug'，在gdb控制台输入:
     * breakpoint kernel.c:21
     * continue
     * print position
     * print offset_from_vga
     */

    /**
     * 让我们几下当前光标位置，我们已经知道怎么实现它了
     */
    char *vga = 0xb8000;
    vga[offset_from_vga] = 'X';
    vga[offset_from_vga + 1] = 0x0f; /* 黑底白字 */
}
