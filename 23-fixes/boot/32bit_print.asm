[bits 32] ; 使用32位保护模式

; 定义常量
VIDEO_MEMORY equ 0xb8000
WHITE_OB_BLACK equ 0x0f ; 每个字符的颜色字节

print_string_pm:
    pusha
    mov edx, VIDEO_MEMORY

print_string_pm_loop:
    mov al, [ebx] ; [ebx]是我们字符的地址
    mov ah, WHITE_OB_BLACK

    cmp al, 0 ; 判断是否到string的结尾
    je print_string_pm_done

    mov [edx], ax ; 保存 character + attribute 在 video memory
    add ebx, 1 ; 下一个字节
    add edx, 2 ; 下一个video memory 位置

    jmp print_string_pm_loop

print_string_pm_done:
    popa
    ret
