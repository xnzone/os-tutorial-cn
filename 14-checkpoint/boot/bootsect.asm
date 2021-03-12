[org 0x7c00]
KERNEL_OFFSET equ 0x1000 ; 和我们使用的链接内核是一样的

    mov [BOOT_DRIVE], dl ; 记住BIOS设置会从'dl'开始驱动
    mov bp, 0x9000
    mov sp, bp
    
    mov bx, MSG_REAL_MODE
    call print
    call print_nl

    call load_kernel ; 从硬盘读取内核
    call switch_to_pm ; 禁用中断，加载GDT 等等，最终跳转到 'BEGIN_PM'
    jmp $ ; 永远不会执行

%include "print.asm"
%include "print_hex.asm"
%include "disk.asm"
%include "gdt.asm"
%include "32bit-print.asm"
%include "switch_pm.asm"

[bits 16]
load_kernel:
    mov bx, MSG_LOAD_KERNEL
    call print
    call print_nl

    mov bx, KERNEL_OFFSET ; 从硬盘读取并且保存在0x1000
    mov dh, 2
    mov dl, [BOOT_DRIVE]
    call disk_load
    ret


[bits 32]
BEGIN_PM:
    mov ebx, MSG_PROT_MODE
    call print_string_pm
    call KERNEL_OFFSET ; 把控制权交给内核
    jmp $ ; 当内核返回控制权给我们的时候，停在这里

BOOT_DRIVE db 0 ; 在内存中保存是一个好主意。因为 'dl'可能会被覆盖
MSG_REAL_MODE db 'Started in 16-bit Real Mode', 0
MSG_PROT_MODE db 'Landed in 32-bit Protected Mode', 0
MSG_LOAD_KERNEL db 'Loading kernel into memory', 0

; padding
times 510-($-$$) db 0
dw 0xaa55