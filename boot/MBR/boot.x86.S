#include "_mbr.h"

.code16

.globl start16

start16:
    
    cli
  
    xorw %ax,%ax
    movw %ax,%ds
    movw %ax,%es
    movw %ax,%ss

    lgdt gdt_start

    sti


.code32
start32:

    nop


.p2align 2
gdt_start:
    .word 0x0000, 0x0000
    .byte 0x00, 0x00, 0x00, 0x00

    .word 0xffff, 0x0000
    .byte 0x00, 0x9a, 0xcf, 0x00

    .word 0xffff, 0x0000
    .byte 0x00, 0x92, 0xcf, 0x00

gdt_descriptor:
    .word (gdt_descriptor - gdt_start - 1)
    .long gdt_start
