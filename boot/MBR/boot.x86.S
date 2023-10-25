
.code16
.globl start

start16:
    cli
  
    xorw    %ax,%ax
    movw    %ax,%ds
    movw    %ax,%es
    movw    %ax,%ss



.code32
start32:

    
