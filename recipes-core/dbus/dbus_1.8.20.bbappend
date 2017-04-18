pkg_postinst_dbus_prepend() {
	readlink -f /sbin/init | grep systemd && exit 0
}
