你需要通过谷歌预先了解的概念：control structures, function calling, strings

**目标：学会使用汇编编码**

我们将进一步自定义引导扇区

在第7节课， 我们将从硬盘中开始读取引导扇区代码，这是在加载内核之前的最后一步。但是在这之前，我们需要用控制结构、函数调用、字符串编写相关代码。在跳转到硬盘和内核之前，我们必须适应这些概念

Strings(字符串)
---------
定义string类似于bytes，但是为了能够终止他们，使用一个null-byte终止（是的，类似于C）

```armnasm
mystring:
    db 'Hello, World', 0
```

注意，引用的文本会被汇编转换成ASCII，然而单个的0会被转换成空字节(null byte)`0x00`

Control structures(控制结构)
--------
我们已经使用了一个`jmp $`用于无限循环的控制结构

汇编跳转被定义成之前指令结果。例如

```armnasm
cmp ax, 4       ; 如果 ax = 4
je ax_is_four   ; 满足条件的处理，跳转到这个label进行处理
jmp else        ; else 做其他的事情
jmp endif       ; 最后，正常结束

ax_is_four:
    ......
    jmp endif

else:
    ......
    jmp endif ;通常不需要，但是还是在这个地方输出

endif:
```
在你的脑海里使用高级语言思考这个过程，然后使用汇编实现它

有很多`jmp`条件：if equal, if less than, 等等。谷歌上有更完美的解释

Calling functions(函数调用)
--------
正如你猜想的一样，调用一个函数就是跳转到某个label

棘手的部分是参数传递。有两个步骤用于解决参数传递：
1. 程序员知道他们共享一个指定的寄存器或者内存地址
2. 编写一小部分代码，创建一个函数调用，并且没有其他影响

步骤1是非常简单的，`al`(实际上是`ax`)寄存器可以用于参数传递

```armnasm
mov al, 'X'
jmp print
endprint:

...

print:
    mov ah, 0x0e    ; tty模式
    int 0x10        ; 假设 'al' 已经有所有的字符串
    jmp endprint    ; 之前已经有的label
```

