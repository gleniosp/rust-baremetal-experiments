main.elf: main.rs link.ld
	rustc \
	--target thumbv7m-none-eabi \
	-C opt-level=0 \
	-g \
	-C target-cpu=cortex-m3 \
	-C linker=arm-none-eabi-gcc \
	-C link-arg=-Tlink.ld \
	-C link-arg=-nostartfiles \
	main.rs -o main.elf

qemu: main.elf
	qemu-system-arm \
	-machine stm32vldiscovery \
	-nographic -kernel main.elf -S -s

gdb: main.elf
	gdb-multiarch main.elf

objdump: main.elf
	arm-none-eabi-objdump -D main.elf > main.asm

.PHONY: clean
clean:
	rm -rf main.elf main .gdb_history *.o
