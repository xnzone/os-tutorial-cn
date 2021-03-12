C_SOURCES = $(wildcard kernel/*.c drivers/*.c)
HEADERS = $(wildcard kernel/*.h drivers/*.h)
# Nice syntax for file extension replacement
OBJ = ${C_SOURCES:.c=.o}

# Change this if your cross-compiler is somewhere else
CC = /usr/local/i386elfgcc/bin/i386-elf-gcc
GDB = /usr/local/i386elfgcc/bin/i386-elf-GDB
# -g: Use debuggin symbols in gcc
CFLAGS = -g

# First rule is run by default
os-image.bin: boot/bootsect.bin kernel.bin
		cat $^ > os-image.bin

# '--oformat binary' deletes all symbols as collateral, so we don't need to 'strip' them manually on this case
kernel.bin: boot/kernel_entry.o ${OBJ}
		i386-elf-ld -o $@ -Ttext 0x1000 $^ --oformat binary
	
# Used for debugging purposes
kernel.elf: boot/kernel_entry.o ${OBJ}
		