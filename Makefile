# Linloader, Boots Linux/ARM on RISC OS based systems.
# Copyright (C) 1999  Timothy Baldwin
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

# $Id: Makefile,v 1.5 2004/03/20 12:11:25 pnaulls Exp $

STUBS= C:stubsg.o
LIBS = zlib.o.zlib OSLib:o.oslib32

#LLL_OBJS=asm.o fixup.o mcid.o id_sys.o ram.o boot.o name.o version.o msgs.o \
 die.o xmalloc.o init.o params.o bootfile.o bootgzip.o strdup.o

LLL_OBJS=o.asm o.fixup o.mcid o.id_sys o.ram o.boot o.name o.version o.msgs \
 o.die o.xmalloc o.init o.params o.bootfile o.bootgzip o.strdup

LL_OBJS=main.o getopt.o getopt1.o fpf_hack.o lll.o


# Use Norcroft
CFLAGS= -IOSLib: -Izlib -throwback -depend !Depend -strict -DNDEBUG
CC=cc
AS=objasm
ASFLAGS= -throwback
LD=link
LDFLAGS=$(STUBS) $(LIBS)
AR=libfile

# Use GCC
#CFLAGS= -IOSLib: -Izlib -mlibscl -O2 -Wall -W -mthrowback  
#CC=gcc
#AS=gcc
#ASFLAGS= -c -Wa,-t,SA1 -x assembler
#LD=gcc
#LDFLAGS=-mlibscl ${LIBS}
#AR=libfile


TARGET=@.Linloader.LL

#dist: Linloader._M1 Linloader.LL o.lll
dist: $(TARGET) lll.o

clean:
	remove $(TARGET)
	-wipe Linloader._* ~C~V
	-wipe o.* ~C~V

.c.o:
	$(CC) ${CFLAGS} -c -o $@ $<
.s.o:
	$(AS) $(ASFLAGS) $< -o $@

$(TARGET): $(LL_OBJS)
	$(LD) -o $(TARGET) $(LL_OBJS) $(LDFLAGS)

#squeeze -v Linloader.LL

.SUFFIXES: .o .c .s


lll.o: ${LLL_OBJS}
	$(AR) -c $@ ${LLL_OBJS}

bootgzip.o: bootfile.c
	$(CC) ${CFLAGS} -DBOOT_GZIP -c -o bootgzip.o bootfile.c

Linloader._M1: LibM.M1 AbsM.M1
	print LibM.M1 { > Linloader._M1 }
	print AbsM.M1 { >> Linloader._M1 }

# Dynamic dependencies:

o.getopt:	c.getopt
o.getopt:	h.getopt
o.getopt1:	c.getopt1
o.getopt1:	h.getopt
o.boot:	c.boot
o.boot:	OSLib:oslib.h.osfscontrol
o.boot:	OSLib:oslib.h.types
o.boot:	OSLib:oslib.h.os
o.boot:	OSLib:oslib.h.oscore32
o.boot:	OSLib:oslib.h.osf32
o.boot:	OSLib:oslib.h.fileswitch
o.boot:	OSLib:oslib.h.fileswch32
o.boot:	OSLib:oslib.h.osfsctrl32
o.boot:	OSLib:oslib.h.podule
o.boot:	h.internal
o.boot:	h.lll
o.boot:	OSLib:oslib.h.osfind
o.boot:	OSLib:oslib.h.osfind32
o.boot:	OSLib:oslib.h.messagetrans
o.version:	c.version
o.die:	c.die
o.die:	h.internal
o.die:	h.lll
o.die:	OSLib:oslib.h.osfind
o.die:	OSLib:oslib.h.types
o.die:	OSLib:oslib.h.os
o.die:	OSLib:oslib.h.oscore32
o.die:	OSLib:oslib.h.osf32
o.die:	OSLib:oslib.h.fileswitch
o.die:	OSLib:oslib.h.fileswch32
o.die:	OSLib:oslib.h.osfind32
o.die:	OSLib:oslib.h.messagetrans
o.params:	c.params
o.params:	OSLib:oslib.h.osbyte
o.params:	OSLib:oslib.h.types
o.params:	OSLib:oslib.h.os
o.params:	OSLib:oslib.h.oscore32
o.params:	OSLib:oslib.h.osf32
o.params:	h.internal
o.params:	h.lll
o.params:	OSLib:oslib.h.osfind
o.params:	OSLib:oslib.h.fileswitch
o.params:	OSLib:oslib.h.fileswch32
o.params:	OSLib:oslib.h.osfind32
o.params:	OSLib:oslib.h.messagetrans
o.params:	h.setup
o.strdup:	c.strdup
o.strdup:	h.internal
o.strdup:	h.lll
o.strdup:	OSLib:oslib.h.osfind
o.strdup:	OSLib:oslib.h.types
o.strdup:	OSLib:oslib.h.os
o.strdup:	OSLib:oslib.h.oscore32
o.strdup:	OSLib:oslib.h.osf32
o.strdup:	OSLib:oslib.h.fileswitch
o.strdup:	OSLib:oslib.h.fileswch32
o.strdup:	OSLib:oslib.h.osfind32
o.strdup:	OSLib:oslib.h.messagetrans
o.main:	c.main
o.main:	C:h.kernel
o.main:	OSLib:oslib.h.os
o.main:	OSLib:oslib.h.types
o.main:	OSLib:oslib.h.oscore32
o.main:	OSLib:oslib.h.osf32
o.main:	OSLib:oslib.h.osbyte
o.main:	h.getopt
o.main:	h.lll
o.main:	OSLib:oslib.h.osfind
o.main:	OSLib:oslib.h.fileswitch
o.main:	OSLib:oslib.h.fileswch32
o.main:	OSLib:oslib.h.osfind32
o.main:	OSLib:oslib.h.messagetrans
o.main:	h.msgs
o.ram:	c.ram
o.ram:	OSLib:oslib.h.os
o.ram:	OSLib:oslib.h.types
o.ram:	OSLib:oslib.h.oscore32
o.ram:	OSLib:oslib.h.osf32
o.ram:	h.internal
o.ram:	h.lll
o.ram:	OSLib:oslib.h.osfind
o.ram:	OSLib:oslib.h.fileswitch
o.ram:	OSLib:oslib.h.fileswch32
o.ram:	OSLib:oslib.h.osfind32
o.ram:	OSLib:oslib.h.messagetrans
o.msgs:	c.msgs
o.msgs:	OSLib:oslib.h.os
o.msgs:	OSLib:oslib.h.types
o.msgs:	OSLib:oslib.h.oscore32
o.msgs:	OSLib:oslib.h.osf32
o.msgs:	OSLib:oslib.h.messagetrans
o.msgs:	h.xmalloc
o.msgs:	h.msgs
o.xmalloc:	c.xmalloc
o.xmalloc:	h.internal
o.xmalloc:	h.lll
o.xmalloc:	OSLib:oslib.h.osfind
o.xmalloc:	OSLib:oslib.h.types
o.xmalloc:	OSLib:oslib.h.os
o.xmalloc:	OSLib:oslib.h.oscore32
o.xmalloc:	OSLib:oslib.h.osf32
o.xmalloc:	OSLib:oslib.h.fileswitch
o.xmalloc:	OSLib:oslib.h.fileswch32
o.xmalloc:	OSLib:oslib.h.osfind32
o.xmalloc:	OSLib:oslib.h.messagetrans
o.init:	c.init
o.init:	C:h.kernel
o.init:	OSLib:oslib.h.os
o.init:	OSLib:oslib.h.types
o.init:	OSLib:oslib.h.oscore32
o.init:	OSLib:oslib.h.osf32
o.init:	OSLib:oslib.h.osmodule
o.init:	OSLib:oslib.h.taskwindow
o.init:	OSLib:oslib.h.wimp
o.init:	OSLib:oslib.h.osspriteop
o.init:	OSLib:oslib.h.font
o.init:	OSLib:oslib.h.wimp32
o.init:	h.internal
o.init:	h.lll
o.init:	OSLib:oslib.h.osfind
o.init:	OSLib:oslib.h.fileswitch
o.init:	OSLib:oslib.h.fileswch32
o.init:	OSLib:oslib.h.osfind32
o.init:	OSLib:oslib.h.messagetrans
o.init:	h.msgs
o.bootfile:	c.bootfile
o.bootfile:	C:h.swis
o.bootfile:	C:h.kernel
o.bootfile:	C:h.kernel
o.bootfile:	OSLib:oslib.h.osfind
o.bootfile:	OSLib:oslib.h.types
o.bootfile:	OSLib:oslib.h.os
o.bootfile:	OSLib:oslib.h.oscore32
o.bootfile:	OSLib:oslib.h.osf32
o.bootfile:	OSLib:oslib.h.fileswitch
o.bootfile:	OSLib:oslib.h.fileswch32
o.bootfile:	OSLib:oslib.h.osfind32
o.bootfile:	OSLib:oslib.h.osargs
o.bootfile:	OSLib:oslib.h.osargs32
o.bootfile:	OSLib:oslib.h.osgbpb
o.bootfile:	OSLib:oslib.h.osgbpb32
o.bootfile:	h.internal
o.bootfile:	h.lll
o.bootfile:	OSLib:oslib.h.osfind
o.bootfile:	OSLib:oslib.h.messagetrans
o.bootgzip:	c.bootfile
o.bootgzip:	C:h.swis
o.bootgzip:	C:h.kernel
o.bootgzip:	C:h.kernel
o.bootgzip:	OSLib:oslib.h.osfind
o.bootgzip:	OSLib:oslib.h.types
o.bootgzip:	OSLib:oslib.h.os
o.bootgzip:	OSLib:oslib.h.oscore32
o.bootgzip:	OSLib:oslib.h.osf32
o.bootgzip:	OSLib:oslib.h.fileswitch
o.bootgzip:	OSLib:oslib.h.fileswch32
o.bootgzip:	OSLib:oslib.h.osfind32
o.bootgzip:	OSLib:oslib.h.osargs
o.bootgzip:	OSLib:oslib.h.osargs32
o.bootgzip:	OSLib:oslib.h.osgbpb
o.bootgzip:	OSLib:oslib.h.osgbpb32
o.bootgzip:	h.internal
o.bootgzip:	h.lll
o.bootgzip:	OSLib:oslib.h.osfind
o.bootgzip:	OSLib:oslib.h.messagetrans
o.bootgzip:	zlib.h.zlib
o.bootgzip:	zlib.h.zconf
o.id_sys:	c.id_sys
o.id_sys:	h.internal
o.id_sys:	h.lll
o.id_sys:	OSLib:oslib.h.osfind
o.id_sys:	OSLib:oslib.h.types
o.id_sys:	OSLib:oslib.h.os
o.id_sys:	OSLib:oslib.h.oscore32
o.id_sys:	OSLib:oslib.h.osf32
o.id_sys:	OSLib:oslib.h.fileswitch
o.id_sys:	OSLib:oslib.h.fileswch32
o.id_sys:	OSLib:oslib.h.osfind32
o.id_sys:	OSLib:oslib.h.messagetrans
o.id_sys:	h.msgs
