const microzig = @import("microzig");
const chip = microzig.chip;
const cpu = microzig.cpu;

pub fn main() !void {
    chip.peripherals.RCC.APB2PCENR.modify(.{ .IOPCEN = 1 });

    chip.peripherals.GPIOC.CFGLR.modify(.{ .CNF4 = 0, .MODE4 = 1 });

    while (true) {
        chip.peripherals.GPIOC.OUTDR.modify(.{ .ODR4 = 1 });
        busy_delay(1000);
        chip.peripherals.GPIOC.OUTDR.modify(.{ .ODR4 = 0 });
        busy_delay(1000);
    }
}

inline fn busy_delay(comptime ms: u32) void {
    const cpu_frequency = if (@hasDecl(cpu, "cpu_frequency")) cpu.cpu_frequency else 8_000_000;
    const cycles_per_ms = cpu_frequency / 1_000;
    const loop_cycles = if (cpu.cpu_name == .@"qingkev2-rv32ec") 4 else 3;
    const limit = cycles_per_ms * ms / loop_cycles;

    var i: u32 = 0;
    while (i < limit) : (i += 1) {
        asm volatile ("" ::: "memory");
    }
}
