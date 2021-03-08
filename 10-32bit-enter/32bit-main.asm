[org 0x7c00] ; 引导扇区偏移
    mov bp, 0x9000 ; 设置栈
    mov sp, bp

    mov bx, MSG_REAL_MODE
    call print ; 在BIOS消息后写入

    call switch_to_pm
    jmp $ ; 实际上永远不会执行

%include "../05-bootsector-functions-strings/boot_sect_print.asm"
%include "../09-32bit-gdt/32bit-gdt.asm"
%include "../08-32bit-print/32bit-print.asm"
%include "32bit-switch.asm"

[bits 32]
BEGIN_PM: ; 切换之后，将从这里开始
    mov ebx, MSG_PROT_MODE
    call print_string_pm ; 注意 将在顶部左边角落重写
    jmp $

MSG_REAL_MODE db "Started in 16-bit real mode", 0
MSG_PROT_MODE db "Loaded 32-bit protected mode", 0

; 引导扇区
times 510-($-$$) db 0
dw 0xaa55