
ODIR = O
DDIR = D


ifeq ($(OS),Windows_NT)
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

CCFLAGS = -fno-pic -static -fno-builtin -fno-strict-aliasing -O2 -Wall -MD -ggdb -m32 -Werror -fno-omit-frame-pointer  -fno-pic -nostdinc 
CCFLAGS_EXTD =


LDFLAGS = -melf_i386


ifeq ($(OS),Windows_NT)
	LDFLAGS = -mi386pe
endif


LDFLAGS_EXTD =


include boot/MBR/Makefrag
include boot/GPT/Makefrag


default: $(DDIR) $(ODIR) .MBR_BLoader .GPT_BLoader

$(ODIR):
	$(MKDIR) $@

$(DDIR):
	$(MKDIR) $@


.PHONY: default
