#include "_mbr.h"

.code16

.globl start16

start16:
    
    cli
  
    xorw %ax, %ax
    movw %ax, %ds
    movw %ax, %es
    movw %ax, %ss

    lgdt gdt_descriptor
    movl %cr0, %eax
    orl  $0x1, %eax
    movl %eax, %cr0

    ljmp $(1<<3), $start32


.code32
start32:

    movw    $(2<<3), %ax
    movw    %ax, %ds
    movw    %ax, %es
    movw    %ax, %ss
    movw    $00, %ax
    movw    %ax, %fs
    movw    %ax, %gs

    movl $start16, %esp

    call wait_for_MM_disk
    

wait_for_MM_disk:
    mov   $0x1f7, %dx

.wait_loop:

    inb   (%dx) , %al
    testb $0b11000000, %al
    jne   .wait_loop
    
    ret


read_lba_sect_MM_disk:

    call wait_for_MM_disk



    ret


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
