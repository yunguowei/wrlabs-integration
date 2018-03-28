FILESEXTRAPATHS_append := "${THISDIR}/files:"

SRC_URI += " \
	file://RS9113_AP_BT_DUAL_MODE.rps \
	file://RS9113_WLAN_BT_DUAL_MODE.rps \
	file://RS9113_WLAN_QSPI.rps \
	file://RS9113_WLAN_ZIGBEE.rps \
	file://RS9113_ZIGBEE_COORDINATOR.rps \
	file://RS9113_ZIGBEE_ROUTER.rps \
	"

do_install_append() {
	cp ${WORKDIR}/RS9113* ${D}${nonarch_base_libdir}/firmware/
}

PACKAGES =+ "${PN}-rs9113" 
FILES_${PN}-rs9113 += " \
	${nonarch_base_libdir}/firmware/RS9113* \
"
