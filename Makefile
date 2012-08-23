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

# $Id: Makefile,v 1.9 1999/07/25 19:18:02 uid1 Exp $

STUBS= C:o.stubs
ZLIB= C:o.zlib
LLL_OBJS=o.asm o.fixup o.mcid o.id_sys o.ram o.boot \
 o.die o.xmalloc o.init o.params o.bootfile o.bootgzip
LL_OBJS=o.main o.getopt o.getopt1 o.fpf_hack o.lll ${STUBS} OSLib:o.oslib ${ZLIB}
CFLAGS= ${CFLAGS} -IOS: -IC:

dist: Linloader o.lll

clean:
	remove @.Linloader
	-wipe o.* ~C~V

Linloader: ${LL_OBJS}
	link -aif -o Linloader ${LL_OBJS}
	squeeze -v Linloader

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


# Dynamic dependencies:
o.main:	c.main
o.main:	C:h.kernel
o.main:	OS:h.os
o.main:	OS:h.types
o.main:	OS:h.osbyte
o.main:	h.getopt
o.main:	h.internal
o.main:	OS:h.types
o.main:	h.lll
o.main:	OS:h.osfind
o.main:	OS:h.fileswitch
o.getopt:	c.getopt
o.getopt:	h.getopt
o.getopt1:	c.getopt1
o.getopt1:	h.getopt
o.fpf_hack:	c.fpf_hack
o.fpf_hack:	C:h.kernel
o.id_sys:	c.id_sys
o.id_sys:	h.internal
o.id_sys:	OS:h.types
o.ram:	c.ram
o.ram:	OS:h.os
o.ram:	OS:h.types
o.ram:	h.internal
o.ram:	OS:h.types
o.boot:	c.boot
o.boot:	OS:h.osfscontrol
o.boot:	OS:h.types
o.boot:	OS:h.os
o.boot:	OS:h.fileswitch
o.boot:	OS:h.podule
o.boot:	h.internal
o.boot:	OS:h.types
o.die:	c.die
o.die:	C:h.kernel
o.xmalloc:	c.xmalloc
o.xmalloc:	h.internal
o.xmalloc:	OS:h.types
o.init:	c.init
o.init:	C:h.kernel
o.init:	OS:h.os
o.init:	OS:h.types
o.init:	OS:h.osmodule
o.init:	OS:h.taskwindow
o.init:	h.internal
o.init:	OS:h.types
o.params:	c.params
o.params:	OS:h.osbyte
o.params:	OS:h.types
o.params:	OS:h.os
o.params:	h.internal
o.params:	OS:h.types
o.params:	h.setup
o.bootfile:	c.bootfile
o.bootfile:	C:h.kernel
o.bootfile:	OS:h.osfind
o.bootfile:	OS:h.types
o.bootfile:	OS:h.os
o.bootfile:	OS:h.fileswitch
o.bootfile:	OS:h.osargs
o.bootfile:	OS:h.osgbpb
o.bootfile:	h.internal
o.bootfile:	OS:h.types
o.bootgzip:	c.bootfile
o.bootgzip:	C:h.kernel
o.bootgzip:	OS:h.osfind
o.bootgzip:	OS:h.types
o.bootgzip:	OS:h.os
o.bootgzip:	OS:h.fileswitch
o.bootgzip:	OS:h.osargs
o.bootgzip:	OS:h.osgbpb
o.bootgzip:	h.internal
o.bootgzip:	OS:h.types
o.bootgzip:	C:h.zlib
o.bootgzip:	C:h.zconf
