
DDIR = D
IDIR = I
ODIR = O


ifeq ($(OS),Windows_NT)
	RM = del /Q /F
	RMDIR = rmdir /s /q
	MKDIR = mkdir
else
	RM = rm -f
	RMDIR = rmdir -p
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


default: $(DDIR) $(IDIR) $(ODIR) .MBR_BLoader .GPT_BLoader


$(ODIR):
	$(MKDIR) $@

$(DDIR):
	$(MKDIR) $@

$(IDIR):
	$(MKDIR) $@


clean:
	$(RMDIR) $(DDIR)	
	$(RMDIR) $(IDIR)
	$(RMDIR) $(ODIR)


.PHONY: default
