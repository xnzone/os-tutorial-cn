; 在isr.c的定义
[extern isr_handler]

; ISR代码
isr_common_stub:
    ; 1. 保存CPU状态
    pusha ; push edi,esi,ebp,esp,ebx,edx,ecx,eax
    mov ax, ds ; eax低16位 = ds
    push eax ; 保存数据段描述符
    mov ax, 0x10 ; 内核数据段描述符
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    ; 2. 调用C处理
    call isr_handler

    ; 3. 恢复状态
    pop eax
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    popa
    add esp, 8 ; 清理压如的错误码和ISR数字
    sti
    iret ; 立马弹出五个事情: CS, EIP, EFLAGS, SS, ESP

; 当处理函数正在运行的时候，我们没有获取更多关于中断调用者的信息
; 所以我们对每次中断都需要不同的处理函数
; 而且，一些中断压入错误码到栈上，但是其他没有
; 所以，我们对这些没有的，需要压入一个无用的错误码
; 以至于我们的栈是连续的，对于这些处理中断函数来说

; 首先让ISRs全局化
global isr0
global isr1
global isr2
global isr3
global isr4
global isr5
global isr6
global isr7
global isr8
global isr9
global isr10
global isr11
global isr12
global isr13
global isr14
global isr15
global isr16
global isr17
global isr18
global isr19
global isr20
global isr21
global isr22
global isr23
global isr24
global isr25
global isr26
global isr27
global isr28
global isr29
global isr30
global isr31

; 0: 除数为0的异常
isr0:
    cli
    push byte 0
    push byte 0
    jmp isr_common_stub

; 1: 调试异常
isr1:
   cli
   push byte 0
   push byte 1
   jmp isr_common_stub

; 2: 无掩码中断异常
isr2:
    cli
    push byte 0
    push byte 2
    jmp isr_common_stub

; 3: 中断3异常
isr3:
    cli
    push byte 0
    push byte 3
    jmp isr_common_stub

; 4: INT0 异常
isr4:
    cli
    push byte 0
    push byte 4
    jmp isr_common_stub

; 5: 边界溢出异常
isr5:
    cli
    push byte 0
    push byte 5
    jmp isr_common_stub

; 6: 无效操作数异常
isr6:
    cli
    push byte 0
    push byte 6
    jmp isr_common_stub

; 7: 多核处理器不可用异常
isr7:
    cli
    push byte 0
    push byte 7
    jmp isr_common_stub

; 8: 多种错误异常(带有错误码)
isr8:
    cli
    push byte 8
    jmp isr_common_stub

; 9: 多核处理器段超负荷异常
isr9:
    cli
    push byte 0
    push byte 9
    jmp isr_common_stub

; 10: 坏TSS异常(带错误码)
isr10:
    cli
    push byte 10
    jmp isr_common_stub

; 11: 段不存在异常(带错误码)
isr11:
    cli
    push byte 11
    jmp isr_common_stub

; 12: 栈错误异常(带错误码)
isr12:
    cli
    push byte 12
    jmp isr_common_stub

; 13: 普通保护错误(带错误码)
isr13:
    cli
    push byte 13
    jmp isr_common_stub

; 14: 页错误异常(带错误码)
isr14:
    cli
    push byte 14
    jmp isr_common_stub

; 15: 恢复异常
isr15:
    cli
    push byte 0
    push byte 15
    jmp isr_common_stub

; 16: 浮点指针异常
isr16:
    cli
    push byte 0
    push byte 16
    jmp isr_common_stub

; 17: 对齐检查异常
isr17:
    cli
    push byte 0
    push byte 17
    jmp isr_common_stub

; 18: 机器检查异常
isr18:
    cli
    push byte 0
    push byte 18
    jmp isr_common_stub

; 19: 恢复
isr19:
    cli
    push byte 0
    push byte 19
    jmp isr_common_stub

; 20: 恢复
isr20:
    cli
    push byte 0
    push byte 20
    jmp isr_common_stub

; 21: 恢复
isr21:
    cli
    push byte 0
    push byte 21
    jmp isr_common_stub

; 22: 恢复
isr22:
    cli
    push byte 0
    push byte 22
    jmp isr_common_stub

; 23: 恢复
isr23:
    cli
    push byte 0
    push byte 23
    jmp isr_common_stub

; 24: 恢复
isr24:
    cli
    push byte 0
    push byte 24
    jmp isr_common_stub

; 25: 恢复
isr25:
    cli
    push byte 0
    push byte 25
    jmp isr_common_stub

; 26: 恢复
isr26:
    cli
    push byte 0
    push byte 26
    jmp isr_common_stub

; 27: 恢复
isr27:
    cli
    push byte 0
    push byte 27
    jmp isr_common_stub

; 28: 恢复
isr28:
    cli
    push byte 0
    push byte 28
    jmp isr_common_stub

; 29: 恢复
isr29:
    cli
    push byte 0
    push byte 29
    jmp isr_common_stub

; 30: 恢复
isr30:
    cli
    push byte 0
    push byte 30
    jmp isr_common_stub

; 31: 恢复
isr31:
    cli
    push byte 0
    push byte 31
    jmp isr_common_stub
