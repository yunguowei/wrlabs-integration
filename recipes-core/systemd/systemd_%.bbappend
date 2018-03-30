FILESEXTRAPATHS_append := "${THISDIR}/${PN}:"

SRC_URI += "file://0001-skip-80-net-setup-link.rules-for-wlan-devices.patch"

do_install_append(){
	sed -i 's/^\(ConditionPathExists=\)/#\1/'  ${D}${systemd_unitdir}/system/getty@.service
	ln -sf /dev/null ${D}${sysconfdir}/udev/rules.d/80-net-setup-link.rules
}
