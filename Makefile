
ODIR = O
DDIR = D


ifeq ($(OS), Windows_NT)
	RM = del /Q /F
	MKDIR = mkdir
else
	RM = rm -f
	MKDIR = mkdir -p
endif


CC = gcc
LD = ld

OBJCOPY = objcopy
OBJDUMP = objdump

CCFLAGS = -fno-pic -static -fno-builtin -fno-strict-aliasing -O2 -Wall -MD -ggdb -m32 -Werror -fno-omit-frame-pointer
CCFLAGS_EXTD = -fno-pic -nostdinc -nostdlib -ffreestanding -fno-pie -no-pie

#temp:
LDFLAGS = -mi386pe

LDFLAGS_EXTD = 


include boot/MBR/Makefrag
include boot/GPT/Makefrag


default: $(DDIR) $(ODIR) .MBR_BLoader .GPT_BLoader

$(ODIR):
	MKDIR $@

$(DDIR):
	MKDIR $@


.PHONY: default
