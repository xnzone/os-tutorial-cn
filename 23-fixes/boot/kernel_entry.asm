global _start
[bits 32]

_start:
    [extern kernel_main] ; 定义调用点。必须与kernel.c 'main'函数保持一致
    call kernel_main ; 调用C函数。链接器知道在内存的哪个地方
    jmp $