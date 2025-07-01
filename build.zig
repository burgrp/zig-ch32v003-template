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

    mb.install_firmware(fw, .{ .format = .elf });
    mb.install_firmware(fw, .{ .format = .bin });
}
