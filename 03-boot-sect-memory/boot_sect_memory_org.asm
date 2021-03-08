[org 0x7c00]
mov ah, 0x0e

; 尝试1
; 仍然失败，不管有没有org，因为我们依然采用的是指针地址访问，并不是指向数据的指针
mov al, "1"
int 0x10
mov al, the_secret
int 0x10

; 尝试2
; 用org解决了内存偏移，现在是正确的输出
mov al, "2"
int 0x10
mov al, [the_secret]
int 0x10

; 尝试3
; 正如你所预料的，0x7c00加了两遍，不能正常工作
mov al, "3"
int 0x10
mov bx, the_secret
add bx, 0x7c00
mov al, [bx]
int 0x10

; 尝试4
; 仍然能正常工作，因为没有内存引用指向，所以org模式对此不起作用。直接访问内存地址，总是可以工作，但是不方便
mov al, "4"
int 0x10
mov al, [0x7c2d]
int 0x10

jmp $ ;无限循环

the_secret:
    db "X"

; 填充0和魔术数
times 510-($-$$) db 0
dw 0xaa55