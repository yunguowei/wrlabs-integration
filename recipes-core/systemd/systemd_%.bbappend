do_install_append() {
    ln -sf /lib/udev/rules.d/80-net-setup-link.rules ${D}${sysconfdir}/udev/rules.d/80-net-setup-link.rules
}
