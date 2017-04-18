pkg_postinst_lxc_prepend() {
        readlink -f /sbin/init | grep systemd && exit 0
}
