# Zig-CH32V003 Template

Starter firmware project for the **CH32V003** RISC‑V MCU, built with [MicroZig](https://github.com/ZigEmbeddedGroup/microzig).


## Prerequisites

| Tool | Tested Version | Purpose |
|------|----------------|---------|
| [Zig](https://ziglang.org/download/) | ~~0.14.1 or newer~~ see note below | Build system & compiler |
| [wlink](https://github.com/ch32-rs/wlink) | latest | Flashing over WCH‑LinkE |
| [PicoRVD](https://github.com/aappleby/picorvd/tree/master) | latest | Flashing over PicoRVD

**IMPORTANT** Microzig 0.14.1 contains wrong declaration of flash start. Make sure the version of Microzig includes [PR #618](https://github.com/ZigEmbeddedGroup/microzig/pull/618), commit [bf48511](https://github.com/ZigEmbeddedGroup/microzig/commit/bf485113a12f2bdc3f5f5f86f2ba3d36b0cd767d).

## Building

```bash
make build
```

### Flashing over PicoRVD

```bash
make flashp
```

### Flashing over WCH‑LinkE

```bash
make flashw
```

## License

MIT — see [LICENSE](LICENSE).
