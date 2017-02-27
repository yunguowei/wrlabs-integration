
EXTRA_OECONF += "--enable-compat-libdns_sd"

FILES_libavahi-core += "${libdir}/libdns_sd.so.*"

do_install_append() {
	if [ -e ${D}/usr/include/avahi-compat-libdns_sd/dns_sd.h ] ; then
		mv ${D}/usr/include/avahi-compat-libdns_sd/dns_sd.h ${D}/usr/include/dns_sd.h
	fi
}
