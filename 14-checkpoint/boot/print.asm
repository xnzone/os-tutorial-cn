print:
    pusha

; 在脑子里记住：while(string[i] != 0) { print string[i]; i++}
; 比较字符串结尾(null byte)
start:
    mov al, [bx] ; 'bx'是字符串的基地址
    cmp al, 0
    je done

    ; 在BIOS的帮助下，开始输出的部分
    mov ah, 0x0e
    int 0x10 ; 'al' 已经包含了字符

    ; 递增指针并且进入下一层循环
    add bx, 1
    jmp start

done:
    popa
    ret

print_nl:
    pusha

    mov ah, 0x0e
    mov al, 0x0a ; 换行符
    int 0x10
    mov al, 0x0d; return
    int 0x10

    popa
    ret