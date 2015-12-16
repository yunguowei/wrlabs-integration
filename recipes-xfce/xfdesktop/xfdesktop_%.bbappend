#
# Copyright (C) 2015 Wind River Systems, Inc.
#

FILESPATH_append := ":${@base_set_filespath(['${THISDIR}'], d)}/${PN}"
SRC_URI += "file://xfce-teal.jpg \
            file://xfce-blue.jpg \
            file://xfce4-desktop.xml \
           "

do_install_append(){
    cp -r ${WORKDIR}/xfce-teal.jpg ${D}${datadir}/backgrounds/xfce/
    cp -r ${WORKDIR}/xfce-blue.jpg ${D}${datadir}/backgrounds/xfce/
    mkdir -p ${D}${sysconfdir}/xdg/xfce4/xfconf/xfce-perchannel-xml
    cp ${WORKDIR}/xfce4-desktop.xml ${D}${sysconfdir}/xdg/xfce4/xfconf/xfce-perchannel-xml/
}
