SUMMARY = "Xilinx QEMU - fast open source processor emulator"
HOMEPAGE = "http://www.wiki.xilinx.com/QEMU"
LICENSE = "GPLv2 & LGPLv2.1"
DEPENDS = "glib-2.0 zlib pixman"
RDEPENDS_${PN}_class-target += "bash python"

inherit autotools-brokensep
BBCLASSEXTEND = "native nativesdk"

# QEMU_TARGETS is overridable variable
QEMU_TARGETS ?= "arm-softmmu"

FILES_${PN} += "/*"

EXTRA_OECONF += "--prefix=${bindir}/xilinx --target-list=arm-softmmu --disable-werror  --disable-bluez --disable-libiscsi --with-system-pixman --extra-cflags='${CFLAGS}'"

EXTRA_OECONF_class-nativesdk = "--target-list=arm-softmmu --disable-werror "
export LIBTOOL="${HOST_SYS}-libtool"

do_compile() {
}

do_configure_prepend_class-native() {
	# Append build host pkg-config paths for native target since the host may provide sdl
	BHOST_PKGCONFIG_PATH=$(PATH=/usr/bin:/bin pkg-config --variable pc_path pkg-config || echo "")
	if [ ! -z "$BHOST_PKGCONFIG_PATH" ]; then
		export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:$BHOST_PKGCONFIG_PATH
	fi

	# Undo the -lX11 added by linker-flags.patch, don't assume that host has libX11 installed
	sed -i 's/-lX11//g' Makefile.target
}

do_configure_prepend_class-nativesdk() {
	if [ "${@bb.utils.contains('DISTRO_FEATURES', 'x11', 'x11', '', d)}" = "" ] ; then
		# Undo the -lX11 added by linker-flags.patch
		sed -i 's/-lX11//g' Makefile.target
	fi
}

KVMENABLE = "--enable-kvm"
KVMENABLE_darwin = "--disable-kvm"
KVMENABLE_mingw32 = "--disable-kvm"

do_configure() {
    # Handle distros such as CentOS 5 32-bit that do not have kvm support
    KVMOPTS="--disable-kvm"
    if [ "${PN}" != "qemu-native" -a "${PN}" != "nativesdk-qemu" ] \
       || [ -f /usr/include/linux/kvm.h ] ; then
       KVMOPTS="${KVMENABLE}"
    fi

    ${S}/configure --sysconfdir=${sysconfdir}-xilinx --libexecdir=${libexecdir}-xilinx --localstatedir=${localstatedir} --disable-strip ${EXTRA_OECONF} $KVMOPTS
    test ! -e ${S}/target-i386/beginend_funcs.sh || chmod a+x ${S}/target-i386/beginend_funcs.sh
}

do_install () {
	export STRIP="true"
	autotools_do_install
}


PACKAGECONFIG ??= "fdt sdl alsa"
PACKAGECONFIG_class-native ??= "fdt alsa"
PACKAGECONFIG_class-nativesdk ??= "fdt sdl"
NATIVEDEPS = ""
NATIVEDEPS_class-native = "${@bb.utils.contains('DISTRO_FEATURES', 'x11', 'libxext-native', '',d)}"
PACKAGECONFIG[sdl] = "--enable-sdl,--disable-sdl,libsdl ${NATIVEDEPS},"
PACKAGECONFIG[virtfs] = "--enable-virtfs --enable-attr,--disable-virtfs,libcap attr,"
PACKAGECONFIG[aio] = "--enable-linux-aio,--disable-linux-aio,libaio,"
PACKAGECONFIG[xfs] = "--enable-xfsctl,--disable-xfsctl,xfsprogs,"
PACKAGECONFIG[xen] = "--enable-xen, --disable-xen,,"
#PACKAGECONFIG[quorum] = "--enable-quorum, --disable-quorum, gnutls,"
PACKAGECONFIG[vnc-tls] = "--enable-vnc --enable-vnc-tls,--disable-vnc-tls, gnutls,"
PACKAGECONFIG[vnc-ws] = "--enable-vnc --enable-vnc-ws,--disable-vnc-ws, gnutls,"
PACKAGECONFIG[vnc-sasl] = "--enable-vnc --enable-vnc-sasl,--disable-vnc-sasl,cyrus-sasl,"
PACKAGECONFIG[vnc-jpeg] = "--enable-vnc --enable-vnc-jpeg,--disable-vnc-jpeg,jpeg,"
PACKAGECONFIG[vnc-png] = "--enable-vnc --enable-vnc-png,--disable-vnc-png,libpng,"
PACKAGECONFIG[libcurl] = "--enable-curl,--disable-curl,libcurl,"
PACKAGECONFIG[nss] = "--enable-smartcard-nss,--disable-smartcard-nss,nss,"
PACKAGECONFIG[uuid] = "--enable-uuid,--disable-uuid,util-linux,"
PACKAGECONFIG[curses] = "--enable-curses,--disable-curses,ncurses,"
#PACKAGECONFIG[gtk+] = "--enable-gtk --enable-vte,--disable-gtk --disable-vte,gtk+ libvte,"
PACKAGECONFIG[libcap-ng] = "--enable-cap-ng,--disable-cap-ng,libcap-ng,"
PACKAGECONFIG[ssh2] = "--enable-libssh2,--disable-libssh2,libssh2,"
PACKAGECONFIG[libusb] = "--enable-libusb,--disable-libusb,libusb1"
PACKAGECONFIG[fdt] = "--enable-fdt,--disable-fdt,dtc"
PACKAGECONFIG[alsa] = ",,alsa-lib"
PACKAGECONFIG[glx] = "--enable-glx,--disable-glx,mesa"
#PACKAGECONFIG[lzo] = "--enable-lzo,--disable-lzo,lzo"
#PACKAGECONFIG[numa] = "--enable-numa,--disable-numa,numactl"

EXTRA_OECONF += "${@bb.utils.contains('PACKAGECONFIG', 'alsa', '--audio-drv-list=oss,alsa', '', d)}"

# Qemu target will not build in world build for ARM or Mips
BROKEN_qemuarm = "1"
BROKEN_qemumips64 = "1"
BROKEN_qemumips = "1"

INSANE_SKIP_${PN} = "arch"
