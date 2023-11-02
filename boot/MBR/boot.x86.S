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

spin:
    mov $0x0001, %ebx
    mov $0x7dff, %edi
    call read_lba_sect_MM_disk
    jmp spin

wait_for_MM_disk:
    mov   $0x1f7, %dx

.wait_loop:

    in    (%dx) , %al
    testb $0b11000000, %al
    cmp   $0b01000000, %al
    jne   .wait_loop
    
    ret


/*

    ebx = offset = (lba sector number)

    edi = destin = (destin addres mem)

*/
read_lba_sect_MM_disk:

    call wait_for_MM_disk

    push %ebx
    push %edi

    mov $0x1  ,  %eax
    mov $0x1f2,  %edx
    out %al   , (%dx)

    mov %ebx  ,  %eax
    mov $0x1f3,  %edx
    out %al   , (%dx)

    shr $0x08 ,  %eax
    mov $0x1f4,  %edx
    out %al   , (%dx)

    shr $0x08 ,  %eax
    mov $0x1f5,  %edx
    out %al   , (%dx)

    shr $0x08 ,  %eax
    
    or  $0xffffffe0, %eax

    mov $0x1f6,  %edx
    out %al   , (%dx)

    mov $0x20 ,  %eax
    mov $0x1f7,  %edx
    out %al   , (%dx)

    call wait_for_MM_disk

    mov $0x1f0, %edx
    mov $0x80 , %ecx

    cld
    rep insl (%dx),%es:(%edi)

    pop %ebx
    pop %edi

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
