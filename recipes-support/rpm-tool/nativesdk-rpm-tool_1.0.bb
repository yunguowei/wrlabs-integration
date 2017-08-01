#
# Copyright (C) 2017 Wind River Systems, Inc.
#

DESCRIPTION = "The offline tool to generate RPM with IMA and GPG signature"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/LICENSE;md5=4d92cd373abda3937c2bc47fbc49d690"

S="${WORKDIR}"

inherit nativesdk

SRC_URI = "file://rpm-tool \
           file://ima-tool \
           file://repo-tool \
           "
do_install () {
	install -d ${D}/${sbindir}
	install -m 0755 ${S}/rpm-tool ${D}/${sbindir}/
	install -m 0755 ${S}/ima-tool ${D}/${sbindir}/
	install -m 0755 ${S}/repo-tool ${D}/${sbindir}/
}

FILES_${PN} = "${sbindir}/rpm-tool ${sbindir}/ima-tool ${sbindir}/repo-tool"
