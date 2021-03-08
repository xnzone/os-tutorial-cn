mov ah, 0x0e ; tty模式

mov bp, 0x8000 ; 这个地址远离0x7c00，以便于不会覆盖
mov sp, bp ; 如果栈式空的， sp指向bp

push 'A'
push 'B'
push 'C'

; 为了展示栈增长方向
mov al, [0x7ffe] ; 0x8000 - 2
int 0x10

; 然而现在不要尝试访问 [0x8000],因为此时不工作
; 你只能访问栈顶， 此刻，只能访问 0x7ffe
mov al, [0x8000]
int 0x10

; 使用标准生产者 'pop' 恢复字符
; 我们需要一个辅助寄存器去操作低字节
pop bx
mov al, bl
int 0x10 ; 输出C

pop bx
mov al, bl
int 0x10 ; 输出B

pop bx
mov al, bl
int 0x10 ; 输出A

; 所有数据已经输出了，现在栈式个垃圾了
mov al, [0x8000]
int 0x10

jmp $
times 510-($-$$) db 0
dw 0xaa55
