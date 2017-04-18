pkg_postinst_libvirt_prepend() {
        readlink -f /sbin/init | grep systemd && exit 0
}
