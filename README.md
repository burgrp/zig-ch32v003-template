# Zig-CH32V003 Template

Starter firmware project for the **CH32V003** RISC‑V MCU, built with [MicroZig](https://github.com/ZigEmbeddedGroup/microzig).


## Prerequisites

| Tool | Tested Version | Purpose |
|------|----------------|---------|
| [Zig](https://ziglang.org/download/) | 0.14.1 or newer | Build system & compiler |
| [wlink](https://github.com/ch32-rs/wlink) | latest | Flashing over WCH‑Link(e) |
| WCH‑LinkE | — | USB debug probe |

## Building

```bash
zig build
```

### Flashing

```bash
zig build flash
```

## License

MIT — see [LICENSE](LICENSE).
