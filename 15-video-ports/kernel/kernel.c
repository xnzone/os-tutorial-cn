#include "../drivers/ports.h"

void main() {
    /**
     * 屏幕光标位置：像VGA控制寄存器 (0x3d4)查询字节
     * 14 = 光标高位字节 15 = 光标低位字节
     */
    port_byte_out(0x3d4, 14);
    /* VGA数据寄存器（0x3d5)返回的数据 */
    int position = port_byte_in(0x3d5)
    position = position << 8; /* 高位字节 */
     
}