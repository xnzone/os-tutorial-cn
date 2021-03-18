gdt_start:  ; 不要移除这个label，你需要计算大小并且跳转
    ; GDT从空8byte开始
    dd 0x0 ; 4 byte
    dd 0x0 ; 4 byte

; 分段代码GDT. 基地址 = 0x00000000, 长度 = 0xfffff
; 对于标志位，查阅os-dev.pdf文档，page 36
gdt_code:
    dw 0xffff       ; 段长度，bits 0-15
    dw 0x0          ; 段基地址，bits 0-15
    db 0x0          ; 段基地址，bits 16-23
    db 10011010b    ; 标志位(8bits）
    db 11001111b    ; 标志位(4bits) + 段长度，bits 16-19
    db 0x0          ; 段基地址， bits 24-31

; 数据段GDT。代码段基地址和长度
; 一些标志位改变了，再次查阅os-dev.pdf
gdt_data:
    dw 0xffff
    dw 0x0
    db 0x0
    db 10010010b
    db 11001111b
    db 0x0

gdt_end:

; GDT 描述符
gdt_descriptor:
    dw gdt_end - gdt_start - 1 ; 16位长度，总是比真实的长度少1
    dd gdt_start ; 地址(32位)

; 为之后使用，定义一些常量
CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start