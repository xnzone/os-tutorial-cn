你需要通过谷歌预先了解的概念：memory offsets, pointers

**目标：学习操作系统内存组成**

请打开[this document](http://www.cs.bham.ac.uk/~exr/lectures/opsys/10_11/lectures/os-dev.pdf)第14页, 并且查阅内存结构图

这节课的唯一目的是学习引导扇区保存在哪里

我很直白的告诉你，BIOS放在`0x7C00`,但是一个错误的案例将更能看清这个事实

我们想在屏幕上打印一个`X`,我们将才去4中不同的策略，然后看看哪些可以工作，为什么能工作

打开文件`boot_sect_memory.asm`

首先我们将`X`定义成一个数据，并且使用一个label
```armasm
the_screen:
    db "X"
```