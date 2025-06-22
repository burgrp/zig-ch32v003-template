const microzig = @import("microzig");
const peri = microzig.chip.peripherals;
const cpu = microzig.cpu;

pub fn main() !void {
    peri.RCC.APB2PCENR.modify(.{ .IOPCEN = 1 });

    peri.PFIC.STK_CTLR.raw = 0;
    peri.PFIC.STK_CNTL.raw = 0;
    peri.PFIC.STK_CMPLR.raw = cpu.cpu_frequency / 2 - 1;
    peri.PFIC.STK_CTLR.modify(.{
        .STE = 1,
        .STIE = 1,
        .STCLK = 1,
        .STRE = 1,
    });

    cpu.interrupt.enable(.SysTick);

    peri.GPIOC.CFGLR.modify(.{ .CNF0 = 0, .MODE0 = 1, .CNF4 = 0, .MODE4 = 1 });

    while (true) {
        peri.GPIOC.OUTDR.modify(.{ .ODR4 = 1 });
        busy_delay(500);
        peri.GPIOC.OUTDR.modify(.{ .ODR4 = 0 });
        busy_delay(500);
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

pub const microzig_options: microzig.Options = .{
    .interrupts = .{
        .SysTick = sys_tick_handler,
    },
};

fn sys_tick_handler() callconv(cpu.riscv_calling_convention) void {
    peri.GPIOC.OUTDR.toggle(.{ .ODR0 = 1 });
    peri.PFIC.STK_SR.modify(.{ .CNTIF = 0 });
}
