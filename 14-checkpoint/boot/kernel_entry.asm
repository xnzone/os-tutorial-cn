[bits 32]
[extern main] ; 定义调用点。必须与kernel.c 'main'函数保持一致
call main ; 调用C函数。链接器知道在内存的哪个地方
jmp $