# Overview

Pyjamacafe course for Rust forensics on bare-metal using ARM Cortex-M.

Based on the [Rust embedded book](https://docs.rust-embedded.org/book/).

# Setup

Most tooling came installed as part of the `pyjamacafe/sandbox:latest` Docker image in `./devcontainer/Dockerfile`. Some extra stuff was configured based on the [QEMU section of the Rust embedded book](https://docs.rust-embedded.org/book/start/qemu.html).

Extra steps from the QEMU section after creating this codespace based on the `.devcontainer/devcontainer.json` file:

- Create the `link.ld` file with the contents presented in the book
  - Actually, the course provided a slight different version later, provided by a prompt to Gemini from Google.
- Add the ARMv7 architecture target to the rust compiler:

```bash
rustup target add thumbv7m-none-eabi
```

# Running the code

## Compile code for the ARM Cortex-M

Run:

```bash
make main.elf
```

It'll generate a `main.elf` file. Use the command `file main.elf`, which should print something like:

```
main.elf: ELF 32-bit LSB executable, ARM, EABI5 version 1 (SYSV), statically linked, not stripped
```

confirming that this is a ARM executable.

## Starting QEMU in debug mode

```bash
make qemu
```

Notice that the qemu command from make might compile the code if a binary isn't available or if the code has changed since last run as the qemu command depend on the `make main.elf` command. So if the objective is to run the code with qemu/gdb for testing, it's enough to run `make qemu` instead of both `make main.elf` and `make qemu`.

## Launching GDB

```bash
make gdb
```

After launching GDB, if it doesn't show the command line prompt for it, but show something like `--Type <RET> for more, q to quit, c to continue without paging--` instead, you can just hit `c` and `ENTER` and it'll show the prompt, allowing us to issue GDB commands.

Notice that the gdb command from make might compile the code if a binary isn't available or if the code has changed since last run as the gdb command depend on the `make main.elf` command.

## GDB commands

Inside the launched GDB session, we can run the below commands.

### Connecting to remote target

```
>>> target remote :1234
```

This is required when QEMU runs in debug mode (using the `-s` option, which is a shorthand for `-gdb tcp::1234`) command. Because in debug mode, QEMU waits for a GDB client connection to the provided socket, which in this case, is `tcp:1234`.

# Check assembly code

To check the generated assembly code from the `main.elf` file, run:

```bash
make objdump
```
