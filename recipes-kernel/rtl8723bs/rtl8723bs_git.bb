#
# Copyright (C) 2016 Wind River Systems, Inc.
#

LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/GPL-2.0;md5=801f80980d171dd6425610833a22dbe6"

SRC_URI += "git://github.com/hadess/rtl8723bs.git \
	   "
SRCREV = "56c76c958de0521238d75fc789b2dd7363257458"	
S = "${WORKDIR}/git"

do_configure[noexec] = '1'
do_compile[noexec] = '1'

FWPATH = "/lib/firmware"

do_install(){
        install -d ${D}${FWPATH}
        install -d ${D}${FWPATH}/rtlwifi
        install -m 0644 rtl8723bs_nic.bin ${D}${FWPATH}/rtlwifi
        install -m 0644 rtl8723bs_wowlan.bin ${D}${FWPATH}/rtlwifi
}

FILES_${PN} = "${FWPATH}/rtlwifi \
	     "
