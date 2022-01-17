# The Rux Kernel

![languages](https://img.shields.io/github/languages/count/josehu07/rux-kernel?color=green)
![top-lang](https://img.shields.io/github/languages/top/josehu07/rux-kernel?color=orange)
![code-size](https://img.shields.io/github/languages/code-size/josehu07/rux-kernel?color=lightgrey)
![license](https://img.shields.io/github/license/josehu07/rux-kernel)

Rux - An x86_64 toy operating system kernel written in [Rust](https://www.rust-lang.org/). Rux is a port of the [Hux kernel](https://github.com/josehu07/hux-kernel), my x86 32-bit single-CPU toy kernel written in C, following [the OSTEP book](http://pages.cs.wisc.edu/~remzi/OSTEP/) structure and terminology.

|   Author    | Kernel Src LoC (temp)  | Dev Doc LoC (temp) |
|   :---:     |         :---:          |       :---:        |
| Guanzhou Hu |     Rust + x86 ASM     |      Markdown      |
|  Jan. 2022  |          ???           |        ???         |


## Development Doc

I document the porting process from Hux to Rux, especially the unique challenges and design choices exposed by porting a legacy C kernel to a modern memory-safe programming language, in the [**WIKI pages 📝**](https://github.com/josehu07/rux-kernel/wiki) of this GitHub repository ✭.

It is recommended to also take a look at the [wiki pages](https://github.com/josehu07/hux-kernel/wiki) of Hux to know about its basic design and structure.

If there are any typos / mistakes / errors, please raise an issue!


## Playing with Rux

Requires a Linux host development environment. Tested on Ubuntu Focal.

Clone the repo, set up the Rust development toolchain following [this wiki page](https://github.com/josehu07/rux-kernel/wiki/02.-Rust-Development-Setup), then build Rux by:

```bash
$ make
```

<!-- Or, if you just want to try out Rux without a development toolchain, download both the [released](https://github.com/josehu07/rux-kernel/releases) kernel image `rux.iso` and the initial file system image `vsfs.img` (256MB) to the folder. -->

To run Rux in QEMU **>= v6.2.0**, install QEMU & GRUB following [this wiki section](https://github.com/josehu07/rux-kernel/wiki/02.-Rust-Development-Setup#qemu-emulator--grub-bootloader), then do:

```bash
$ make qemu     # opens a VGA GUI window
```

If you are in a non-GUI environment, it is recommended to redirect VGA output to built-in VNC server, and connect to that server from a VNC client:

```bash
$ make qemu_vnc     # redirects VGA output to VNC server
                    # from VNC client, connect to 'hostname:5901'
```

You will see the QEMU GUI popping up with GRUB loaded. Choose the "`Rux`" option with <kbd>Enter</kbd> to boot into Rux.

<!-- <p align=center> <img src="README-demo.gif" width=720px align=center /> </p> -->

For a taste of what a minimal C kernel looks like, please check out the wiki pages of Hux (recommended). I have every single detail documented there.


## References

Main references:

- [The OSDev Wiki](https://wiki.osdev.org/) (IMPORTANT ✭)
- [Writing an OS in Rust](https://os.phil-opp.com/) by Philipp (IMPORTANT ✭, still updating...)
- [The Hux Kernel](https://github.com/josehu07/hux-kernel) by me, an x86 32-bit toy kernel in C

OS conceptual materials:

- [Operating Systems: Three Easy Pieces](http://pages.cs.wisc.edu/~remzi/OSTEP/) (OSTEP) by Prof. Arpaci-Dusseaus
- My [reading notes](https://www.josehu.com/notes) on OSTEP book & lectures

Check the "References" section of Hux [here](https://github.com/josehu07/hux-kernel/wiki/01.-Prerequisite-Readings) for the full list. You will also need some understanding of and a passion for the [Rust language](https://www.rust-lang.org/), a great next-gen system programming language.


## TODO List

- [x] Dev setup following Philipp's blog
- [ ] Start the porting of Hux kernel
