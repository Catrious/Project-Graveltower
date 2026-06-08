# Makefile
CC = aarch64-none-elf-gcc
CFLAGS = -ffreestanding -nostdinc -mcpu=cortex-a57

all: graveltower.elf

graveltower.elf: boot.o hypervisor.o
	$(CC) $(CFLAGS) -T linker.ld -o $@ $^

%.o: %.S
	$(CC) $(CFLAGS) -c $< -o $@

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm *.o *.elf
