DESCRIPTION = "This implements a Virtual Private Networking Server (VPN) that is \
compatible with Microsoft VPN clients. It allows Windows users to \
connect to an internal firewalled network using their dialup"
SUMMARY = "The PPTP Server for Linux"
HOMEPAGE = "http://poptop.sourceforge.net/"
SECTION = "net"
LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://COPYING;md5=b234ee4d69f5fce4486a80fdaf4a4263"

DEPENDS = "ppp"

SRC_URI = "https://sourceforge.net/projects/poptop/files/pptpd/pptpd-1.4.0/pptpd-1.4.0.tar.gz \
	   file://${PN}.conf \
	   file://${PN}-options \
	   file://${PN}.service \
           "

SRC_URI[md5sum] = "36f9f45c6ffa92bc3b6e24ae2d053505"
SRC_URI[sha256sum] = "8fcd8b8a42de2af59e9fe8cbaa9f894045c977f4d038bbd6346a8522bb7f06c0"

inherit autotools systemd 

EXTRA_OECONF = " \
        --with-libwrap  \
"

do_configure_append () {
	# we don't support logwtmp plugin
	sed -i "s|^subdirs = plugins|subdirs =|" ${B}/Makefile
}

do_install () {
	install -d ${D}${sbindir}
	install -m 0755 "${B}/pptpd" "${D}${sbindir}"
	install -m 0755 "${B}/pptpctrl" "${D}${sbindir}"
	install -d ${D}${sysconfdir}/ppp
	install -m 0755 "${WORKDIR}/${PN}-options" "${D}${sysconfdir}/ppp"
	install -m 0755 "${WORKDIR}/${PN}.conf" "${D}${sysconfdir}"
	install -d ${D}${systemd_unitdir}/system
	install -m 0644 ${WORKDIR}/${PN}.service ${D}${systemd_unitdir}/system	
}

RPROVIDES_${PN} += "${PN}-systemd"
RREPLACES_${PN} += "${PN}-systemd"
RCONFLICTS_${PN} += "${PN}-systemd"
SYSTEMD_SERVICE_${PN} = "${PN}.service"
