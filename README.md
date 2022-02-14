# Linux-on-STM32MP157(Ubuntu)

- Here is a Github Action Project to Generate the file that need to copy to SD Card for STM32MP157 
  (Specially on STM32MP157A-DK1)
- Honestly say,I may update this project slowly because I have lots of works to do.

## Special Thanks:
- armv7-lpae-multiplatform by [@Robert Nelson](https://github.com/RobertCNelson)
- Linux Kernel by [@Linus Torvalds](https://github.com/torvalds) and all guys that support Linux's Development
- Ubuntu Minimal armhf 20.04 from [rcm-ee](https://rcn-ee.com/)

## Current State:
|Tasks|State|
| ----- | ----- |
| Github Action Script | Image Generator Part Unfinished |
| Shell Script | Image Generator Part & README Unfinished |

## Shell Script Test Environment:
| Specifications | more information |
| -------- | ------------------------------------------------------------ |
| Models | Dell Inspiron 7572 laptop computer | 
| BIOS version | Inspiron_7472_7572_1.10.1 |
| Operating system | Pop!_OS 21.10 x86_64 |
| Kernel Version | 5.15.15-76051515-generic |
| Shell | zsh 5.8 |
| Processor | Intel Core i5-8250u @ 1.80 GHz quad-core eight threads |
| Memory | 16 GB(KLEVV DDR4 2400 MHZ) |
| Hard Disk 0 | Samsung 970 Pro (1TB SSD) |
| Hard Disk 1 | PNY CS3030 (1TB SSD) |
| Graphic Card 0 |  Intel HD Graphics 620 (reserve 2 GB memory) |
| Graphic Card 1 | NVIDIA MX 150 4GB |

## Github Actions Environment:

| Specifications | more information |
| -------- | ------------------------------------------------------------ |
| runs-on | ubuntu-latest |
| Dependencies (apt installed) | bison flex swig lzop lzma libmpc-dev u-boot-tools libncurses5-dev build-essential asciidoc binutils bzip2 gawk gettext git libz-dev patch python3 unzip zlib1g-dev lib32gcc1 libc6-dev-i386 subversion uglifyjs p7zip p7zip-full msmtp libssl-dev texinfo libglib2.0-dev xmlto qemu-utils upx libelf-dev autoconf automake libtool autopoint device-tree-compiler antlr3 gperf |
| Cross Compiler (for U-Boot) | gcc-linaro-6.5.0-2018.12-x86_64_arm-linux-gnueabihf |
| Cross Compiler (for Kernel) | gcc-11.1.0-nolibc-arm-linux-gnueabi |
| Current Selected Kernel Version | 5.16.9-armv7-lpae-x13 |
