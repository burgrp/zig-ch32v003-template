PHONY = all build

PORT ?= /dev/ttyACM0

ELF = zig-out/firmware/image.elf

all: build

build:
	zig build

clean:
	rm -rf zig-cache zig-out

flashp: build
	gdb-multiarch -ex "target extended-remote /dev/ttyACM0" -ex "load" -ex "monitor reset" -ex "detach" -ex "quit" ${ELF}

flashw: build
	wlink flash ${ELF}

dis: build
	riscv64-unknown-elf-objdump -dS ${ELF}

size: build
	riscv64-unknown-elf-size ${ELF}
