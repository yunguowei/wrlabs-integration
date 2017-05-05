SUMMARY = "essentials config manager"
DESCRIPTION = "Manage propagation of configuration data from fat32 partition\
 into other container domains"
LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://essential-cfg-start;md5=429404671a30ae37aa8d01a1f2c3cefd;endline=16"

S = "${WORKDIR}"

SRC_URI = "file://essential-cfg-start \
	file://essential-cfg-start.service"

inherit systemd

RPROVIDES_${PN} += "${PN}-systemd"
RREPLACES_${PN} += "${PN}-systemd"
RCONFLICTS_${PN} += "${PN}-systemd"
SYSTEMD_SERVICE_${PN} = "essential-cfg-start.service"

do_install() {
	install -d ${D}${systemd_unitdir}/system
	install -m 0644 ${WORKDIR}/essential-cfg-start.service ${D}${systemd_unitdir}/system
	install -d ${D}/usr/sbin
	install -m 0755 ${WORKDIR}/essential-cfg-start ${D}/usr/sbin
}
