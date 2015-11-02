#
# Copyright (C) 2015 Wind River Systems, Inc.
#

FILESPATH_append := ":${@base_set_filespath(['${THISDIR}'], d)}/${PN}"
SRC_URI += "file://xfce-teal.jpg \
            file://xfce-blue.jpg \
           "

do_install_append(){
    cp -r ${WORKDIR}/xfce-teal.jpg ${D}${datadir}/backgrounds/xfce/
    cp -r ${WORKDIR}/xfce-blue.jpg ${D}${datadir}/backgrounds/xfce/
}
