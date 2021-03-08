[org 0x7c00]
  mov bp, 0x8000 ; 设置远离我们的栈地址
  mov sp, bp

  mov bx, 0x9000 ; es:bx = 0x0000:0x9000 = 0x09000
  mov dh, 2 ; 读取两个扇区，bios把从disk读取的数据保存到'dl',有问题使用'-fda'
  call disk_load

  mov dx, [0x9000] ; 重试第一次加载内容，0xdada
  call print_hex

  call print_nl

  mov dx, [0x9000+512] ; 第一个字从第二个加载扇区, 0xface
  call print_hex

  jmp $

%include "../05-bootsector-functions-strings/boot_sect_print.asm"
%include "../05-bootsector-functions-strings/boot_sect_print_hex.asm"
%include "boot_sect_disk.asm"

; magic number
times 510-($-$$) db 0
dw 0xaa55

; boot sector = sector 1 of cyl 0 of head of hdd 0
; 现在开始 = sector 2
times 256 dw 0xdada ; sector 2 = 512 bytes
times 256 dw 0xface ; sector 3 = 512 bytes
