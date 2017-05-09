pkg_postinst_${PN}_prepend() {
        readlink -f /sbin/init | grep systemd && exit 0
}
