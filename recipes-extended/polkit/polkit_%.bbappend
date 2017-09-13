do_install_append(){
	#Since this dir is always empty and it will cause
	#conflict error with libvirt and systemd, thus rm it
	#directly.
	rm -rf ${D}/${datadir}/polkit-1 
}
