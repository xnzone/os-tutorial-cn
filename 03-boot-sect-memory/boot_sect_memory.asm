mov ah, 0x0e

;尝试1
;失败，因为打印的是内存地址
;不是实际的内容
mov al, "1"
int 0x10
mov al, the_secret
int 0x10

; 尝试2
; 这个方法是打印'the_secret'的内存地址
; 然而，BIOS 把我们的引导扇区放在0x7C00地址处
; 所以我们需要加上0x7C00, 在填充0之前，如尝试3的操作
mov al, "2"
int 0x10
mov al, [the_secret]
int 0x10

; 尝试3
; 加上了BIOS起始的偏移值0x7C00
; 我们需要辅助使用bx,因为 mov al, [ax]是非法的
mov al, "3"
int 0x10
mov bx, the_secret
add bx, 0x7C00
mov al, [bx]
int 0x10

; 尝试4
; 因为X保存在0x2d位置处，所以直接读取0x7C2d内存的数据就可以了
mov al, "4"
int 0x10
mov al, [0x7C2d]
int 0x10

jmp $ ; 无限循环

the_secret:
    ; X的ASCII码是0x58,需要在添加0之前保存
    ; 在这个代码中，字节是0x2d 可以使用'xxd file.bin'检查
    db "X"

; 填充0和魔术数
times 510-($-$$) db 0
dw 0xaa55