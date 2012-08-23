# LinLoader, Boots Linux/ARM on RISC OS based systems.
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

# $Id$

LLL_OBJS=o.asm o.fixup o.mcid o.id_sys o.ram o.boot
LL_OBJS=o.main o.getopt o.getopt1 o.fpf_hack o.linloadlib C:o.Stubs OSLib:o.oslib
# GCC:o.libgcc

dist: LinLoader o.linloadlib

clean:
	remove @.LinLoader
	-wipe o.* ~C~V

LinLoader: ${LL_OBJS}
	link -aif -o LinLoader ${LL_OBJS}
	squeeze -v LinLoader

LinLoaderd: ${LL_DOBJS}
	link -d -aif -o LinLoaderd ${LL_DOBJS}

.SUFFIXES: .o .c .s

.c.o:
	cc -throwback -IOS:,C: -depend !Depend -Wd -strict -c -o $@ $<
#	gcc -O2 -mstubs -D__swi -mthrowback -Wall -IOS: -c -o $@ $<
.s.o:
	as -gcc -throwback -target ARM6 $< -o $@

o.linloadlib: ${LLL_OBJS}
	libfile -o -c $@ ${LLL_OBJS}

o.getopt: c.getopt
	cc -throwback -depend !Depend -W -jmem: -Dfprintf=fprintf_hack -c -o o.getopt c.getopt
#	gcc -O2 -mstubs -Wall -Dfprintf=fprintf_hack -c -o o.getopt c.getopt

o.getopt1: c.getopt1
	cc -throwback -depend !Depend -W -jmem: -Dfprintf=fprintf_hack -c -o o.getopt1 c.getopt1
#	gcc -O2 -mstubs -Wall -Dfprintf=fprintf_hack -c -o o.getopt1 c.getopt1


# Dynamic dependencies:
o.main:	c.main
o.main:	C:h.kernel
o.main:	OS:h.os
o.main:	OS:h.types
o.main:	OS:h.osbyte
o.main:	h.getopt
o.main:	h.boot
o.main:	h.id_sys
o.getopt:	c.getopt
o.getopt:	h.getopt
o.getopt1:	c.getopt1
o.getopt1:	h.getopt
o.fpf_hack:	c.fpf_hack
o.fpf_hack:	C:h.kernel
o.id_sys:	c.id_sys
o.id_sys:	h.ram
o.id_sys:	OS:h.types
o.ram:	c.ram
o.ram:	OS:h.os
o.ram:	OS:h.types
o.ram:	h.ram
o.ram:	OS:h.types
o.boot:	c.boot
o.boot:	C:h.kernel
o.boot:	OS:h.osfind
o.boot:	OS:h.types
o.boot:	OS:h.os
o.boot:	OS:h.fileswitch
o.boot:	OS:h.osargs
o.boot:	OS:h.osgbpb
o.boot:	OS:h.osbyte
o.boot:	OS:h.osmodule
o.boot:	OS:h.osfscontrol
o.boot:	OS:h.podule
o.boot:	OS:h.taskwindow
o.boot:	h.id_sys
o.boot:	h.ram
o.boot:	OS:h.types
o.boot:	h.setup
