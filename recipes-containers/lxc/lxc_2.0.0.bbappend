PACKAGECONFIG[lua] = "--enable-lua,--disable-lua,lua,"

pkg_postinst_${PN}_prepend() {
        readlink -f /sbin/init | grep systemd && exit 0
}
