#
# Copyright (C) 2015 Wind River Systems, Inc.
#

FILESPATH_append := ":${@base_set_filespath(['${THISDIR}'], d)}/${PN}"
SRC_URI += "file://wave.svg \
           "

do_install_append(){
    cp -f ${WORKDIR}/wave.svg ${D}${datadir}/lxdm/themes/Industrial/
}
