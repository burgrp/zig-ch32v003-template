all:
	zig build flash
#	riscv64-unknown-elf-objdump -d zig-out/firmware/blinky.elf >blinky.dis
#	wlink flash --address 0x08000000 zig-out/firmware/test.bin
