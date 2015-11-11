require qemu-xilinx.inc

SRCREV = "732f348311e3b7ae57710ca9fd351de8e0d80a09"

LIC_FILES_CHKSUM = "file://COPYING;md5=441c28d2cf86e15a37fa47e15a72fbac \
                    file://COPYING.LIB;endline=24;md5=c04def7ae38850e7d3ef548588159913"

PV = "2014.4+git${SRCPV}"

SRC_URI = "git://github.com/Xilinx/qemu.git;branch=pub/2014.4.plnx"
S = "${WORKDIR}/git"

DEFAULT_PREFERENCE = "-1"

COMPATIBLE_HOST_class-target_mips64 = "null"
COMPATIBLE_HOST_class-target_mips = "null"
