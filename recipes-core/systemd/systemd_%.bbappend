do_install_append(){
	sed -i 's/^\(ConditionPathExists=\)/#\1/'  ${D}${systemd_unitdir}/system/getty@.service
}
