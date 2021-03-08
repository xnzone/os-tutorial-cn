mov ah, 0x0e ; tty模式
mov al, [the_secret]
int 0x10

mov bx, 0x7c0 ; 记住，短自动左移了4位
mov ds, bx
; 警告：从现在开始，所有的内存引用都被'ds'隐式偏移了
mov al, [the_secret]
int 0x10

mov al, [es:the_secret]
int 0x10

mov bx, 0x7c0
mov es, bx
mov al, [es:the_secret]
int 0x10

jmp $

the_secret:
  db "X"

times 510-($-$$) db 0
dw 0xaa55
