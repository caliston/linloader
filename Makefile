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

# $Id: Makefile,v 1.13 1999/08/11 20:18:17 uid1 Exp $

STUBS= C:o.stubs
ZLIB= C:o.zlib
LLL_OBJS=o.asm o.fixup o.mcid o.id_sys o.ram o.boot o.name o.version o.msgfile\
 o.die o.xmalloc o.init o.params o.bootfile o.bootgzip o.msgopen o.strdup o.msgget
LL_OBJS=o.main o.getopt o.getopt1 o.fpf_hack o.lll ${STUBS} OSLib:o.oslib ${ZLIB}
CFLAGS= ${CFLAGS} -IOSLib: -IC:

dist: Linloader._M1 Linloader.LL o.lll

clean:
	remove Linloader.LL
	-wipe Linloader._* ~C~V
	-wipe o.* ~C~V

Linloader.LL: ${LL_OBJS}
	link -aif -o Linloader.LL ${LL_OBJS}
	squeeze -v Linloader.LL

.SUFFIXES: .o .c .s

.c.o:
	cc -throwback ${CFLAGS} -depend !Depend -strict -c -o $@ $<
.s.o:
	objasm -throwback -NOWarn $< -o $@
#	as -gcc -throwback -target ARM6 $< -o $@

o.lll: ${LLL_OBJS}
	libfile -o -c $@ ${LLL_OBJS}

o.main: c.main
	cc -throwback ${CFLAGS} -depend !Depend -Wd -strict -c -o o.main c.main

o.bootgzip: c.bootfile
	cc ${CFLAGS} -depend !Depend -DBOOT_GZIP -strict -c -o o.bootgzip c.bootfile

o.getopt: c.getopt
	cc -throwback -depend !Depend -W -jmem: -Dfprintf=fprintf_hack -c -o o.getopt c.getopt

o.getopt1: c.getopt1
	cc -throwback -depend !Depend -W -jmem: -Dfprintf=fprintf_hack -c -o o.getopt1 c.getopt1

Linloader._M1: LibM.M1 AbsM.M1
	print LibM.M1 { > Linloader._M1 }
	print AbsM.M1 { >> Linloader._M1 }

# Dynamic dependencies:
o.msgopen:	c.msgopen
o.msgopen:	h.internal
o.msgopen:	h.lll
o.msgopen:	OSLib:oslib.h.osfind
o.msgopen:	OSLib:oslib.h.types
o.msgopen:	OSLib:oslib.h.os
o.msgopen:	OSLib:oslib.h.oscore32
o.msgopen:	OSLib:oslib.h.osf32
o.msgopen:	OSLib:oslib.h.fileswitch
o.msgopen:	OSLib:oslib.h.fileswch32
o.msgopen:	OSLib:oslib.h.osfind32
o.msgopen:	OSLib:oslib.h.messagetrans
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
o.msgget:	c.msgget
o.msgget:	h.internal
o.msgget:	h.lll
o.msgget:	OSLib:oslib.h.osfind
o.msgget:	OSLib:oslib.h.types
o.msgget:	OSLib:oslib.h.os
o.msgget:	OSLib:oslib.h.oscore32
o.msgget:	OSLib:oslib.h.osf32
o.msgget:	OSLib:oslib.h.fileswitch
o.msgget:	OSLib:oslib.h.fileswch32
o.msgget:	OSLib:oslib.h.osfind32
o.msgget:	OSLib:oslib.h.messagetrans
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
o.getopt:	c.getopt
o.getopt:	h.getopt
o.getopt1:	c.getopt1
o.getopt1:	h.getopt
o.fpf_hack:	c.fpf_hack
o.fpf_hack:	C:h.kernel
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
o.name:	c.name
o.version:	c.version
o.msgfile:	c.msgfile
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
o.bootfile:	c.bootfile
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
o.bootgzip:	C:h.zlib
o.bootgzip:	C:h.zconf
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
