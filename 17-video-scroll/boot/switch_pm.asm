[bits 16]
switch_to_pm:
    cli ; 1. 取消中断
    lgdt [gdt_descriptor]   ; 2. 加载GDT描述符
    mov eax, cr0
    or eax, 0x1 ; 3. 将cr0置位
    mov cr0, eax
    jmp CODE_SEG:init_pm    ; 4. 通过不同的段跳转

[bits 32]
init_pm:    ; 现在开始使用32位结构
    mov ax, DATA_SEG    ; 5. 更新段寄存器
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    mov ebp, 0x90000    ; 6. 在空闲空间的顶部更新栈
    mov esp, ebp

    call BEGIN_PM   ; 7. 用自定义代码调用一个周知label