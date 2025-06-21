const std = @import("std");
const microzig = @import("microzig");

pub fn build(b: *std.Build) void {
    const mb = microzig.MicroBuild(.{
        .ch32v = true,
    }).init(b, b.dependency("microzig", .{})) orelse return;

    const fw = mb.add_firmware(.{
        .name = "image",
        .root_source_file = b.path("src/main.zig"),
        .target = mb.ports.ch32v.chips.ch32v003x4,
        .optimize = std.builtin.OptimizeMode.ReleaseSmall,
    });
    const fwStep = mb.add_install_firmware(fw, .{});

    const flash_cmd = b.addSystemCommand(&.{ "wlink", "flash", "--address", "0x08000000" });
    flash_cmd.addFileArg(fw.get_emitted_bin(.bin));
    flash_cmd.step.dependOn(&fwStep.step);

    b.step("flash", "Flash firmware onto board").dependOn(&flash_cmd.step);
}
