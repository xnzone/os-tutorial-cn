[org 0x7c00] ; 告诉汇编，引导扇区偏移置

; 主程序确保参数准备好了，并且调用函数
mov bx, HELLO
call print

call print_nl

mov bx, GOODBYE
call print

call print_nl

mov dx, 0x12fe
call print_hex

; 现在可以挂起了
jmp $

; 需要引入子协程
%include "boot_sect_print.asm"
%include "boot_sect_print_hex.asm"

; 数据
HELLO:
    db 'hello, world',0

GOODBYE:
    db 'Goodbye', 0

; 填充0和魔术数
times 510-($-$$) db 0
dw 0xaa55