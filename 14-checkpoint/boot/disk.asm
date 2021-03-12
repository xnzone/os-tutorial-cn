; 从'd1'加载'dh'扇区到 ES:BX
disk_load:
  pusha
  ; 从磁盘上读取所有需要设置所有寄存器的数据
  ; 因此我们将从'dx'覆盖我们的输入参数。让我们保存它到栈为之后使用
  push dx

  mov ah, 0x02  ; ah <- int 0x13函数， 0x02 = 'read'
  mov al, dh    ; al <- 读取扇区数据(0x01 .. 0x80)
  mov cl, 0x02  ; cl <- sector (0x01 .. 0x11)
                ; 0x01是引导扇区，0x02是第一个可用扇区
  mov ch, 0x00  ; ch <- cylinder (0x0 .. 0x3FF,前两位在'cl') 
                ; dl <- driver numerical。 从BIOS获取并且把其设为调用者参数
                ; (0 = floppy, 1 = flopy2, 0x80 = hdd, 0x81 = hdd2)
  mov dh, 0x00  ; dh <- head number(0x0 .. 0xF)
                ; [es:bx] <- 数据保存的地址
                ; 调用者为我们保存，实际上是为int 13h真实位置
  int 0x13      ; BIOS中断
  jc disk_error ; 如果错误（保存在进位）

  pop dx
  cmp al, dh ; BIOS 也会把扇区读到的数据设置给 'al'，比较一下
  jne sectors_error
  popa
  ret

disk_error:
  mov bx, DISK_ERROR
  call print
  call print_nl
  mov dh, ah ; ah = error code, dl = disk drive 报error
  call print_hex ; 检查代码 https://stanislavs.org/helppc/int_13-1.html
  jmp disk_loop

sectors_error:
  mov bx, SECTORS_ERROR
  call print

disk_loop:
  jmp $

DISK_ERROR: db "Disk read error", 0
SECTORS_ERROR: db "Incorrect number of sector read", 0
