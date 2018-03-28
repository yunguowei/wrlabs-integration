inherit systemd

PV = "1.3.11+git${SRCPV}"

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRCREV = "cfe9ccfa0e4eeb523b50ed8c188d53d6bef0d859"

CFLAGS_append = " -DDEBUG_PPPD -DTRUST_PPPD_TO_DIE -DIP_ALLOCATION -DUSE_KERNEL -DSANITY"

SRC_URI += "file://${PN}.service \
	    file://${PN}.conf \
	    file://options.${PN} \ 
" 

do_install_append () {
	install -d ${D}${sysconfdir}/${PN}
	install -m 0755 ${WORKDIR}/${PN}.conf ${D}${sysconfdir}/${PN}

	install -d ${D}${sysconfdir}/ppp
	install -m 0755 ${WORKDIR}/options.${PN} ${D}${sysconfdir}/ppp

	install -d ${D}${systemd_unitdir}/system
	install -m 0644 ${WORKDIR}/${PN}.service ${D}${systemd_unitdir}/system	
}

RPROVIDES_${PN} += "${PN}-systemd"
RREPLACES_${PN} += "${PN}-systemd"
RCONFLICTS_${PN} += "${PN}-systemd"
SYSTEMD_SERVICE_${PN} = "${PN}.service"
