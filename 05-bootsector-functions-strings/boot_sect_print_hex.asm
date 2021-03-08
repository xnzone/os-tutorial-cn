; 从'dx'接受数据
; 假设调用 dx=0x1234
print_hex:
    pusha
    mov cx, 0; 索引变量

; 策略：获取dx的最后字节，并且转换成ASCII
; ASCII数值：'0'(ASCII 0x30) 到 '9'(ASCII 0x39), 因此仅仅加N
; 字母A-F：'A'(ASCII 0x41) 到 'F'(ASCII 0x46)
; 然后，把ASCII字节移动到正确的字符串位置
hex_loop:
    cmp cx, 4 ; 循环4次
    je end

    ; 1. 把dx最后字节转换成ASCII
    mov ax, dx ; 使用'ax'作为工作寄存器
    add ax, 0x000f ; 0x1234 -> 0x0004 通过把前三位置0
    add al, 0x30 ; 把0x30加到N上，把ASCII码转成"N"
    cmp al, 0x39 ; 如果大于9，再加8，来代表'A'到'F'
    jle step2
    add al, 7 ; 'A'的ASCII是65，而不是58， 所以65-58=7

step2:
    ; 2. 获取正确放置ASCII码的字符串位置
    ; bx 基地址 + 字符串length - char的index
    mov bx, HEX_OUT+5 ; base + length
    sub bx, cx ; index变量
    mov [bx], al ; 把在'al'的ASCII码放到'bx'指针
    ror dx, 4 ; 0x1234 -> 0x4123 -> 0x3412 -> 0x2341 -> 0x1234

    ; index递增，并且循环
    add cx, 1
    jmp hex_loop

end:
    ; 准备参数并且调用函数
    ; 保存在'bx'接收到的数据
    mov bx, HEX_OUT
    call print

    popa
    ret

HEX_OUT:
    db '0x0000', 0 ; 为新的字符串重置内存