PACKAGECONFIG[bluez4] = "--enable-bluez4,--disable-bluez4,bluez4 sbc dbus"
PACKAGECONFIG[bluez5] = "--enable-bluez5,--disable-bluez5,bluez5 sbc dbus"

PACKAGECONFIG = "${@bb.utils.contains('DISTRO_FEATURES', 'bluetooth', 'bluez5', '', d)} \
		   ${@bb.utils.contains('DISTRO_FEATURES', 'bluetooth', 'dbus', '', d)} \
                   ${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'systemd', '', d)} \
                   ${@bb.utils.contains('DISTRO_FEATURES', 'zeroconf', 'avahi', '', d)} \
                   ${@bb.utils.contains('DISTRO_FEATURES', 'x11', 'x11', '', d)}"

