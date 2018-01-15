do_install_append(){
	echo "track_containers=1" >${D}${sysconfdir}/c3-ctl.rc
}
