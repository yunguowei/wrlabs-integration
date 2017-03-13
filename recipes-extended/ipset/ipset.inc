DESCRIPTION = "IP set framework"
SECTION = "kernel/modules"
LICENSE = "GPLv2"
DEPENDS += "virtual/libc"
LIC_FILES_CHKSUM = "file://COPYING;md5=59530bdf33659b29e73d4adb9f9f6552"

inherit autotools pkgconfig

PR="r0"

SRC_URI = " \
	http://ipset.netfilter.org/ipset-${PV}.tar.bz2 \
	"

DEPENDS = "libmnl"

FILES_${PN} = "${sbindir} ${libdir}"
FILES_${PN}-doc = "${mandir}"

EXTRA_OECONF += " \
		--with-kmod=no \
	"

do_compile () {
	oe_runmake
}

do_install () {
	oe_runmake install PREFIX=${prefix} DESTDIR=${D}
}
