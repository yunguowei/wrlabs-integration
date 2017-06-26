#
# Copyright (C) 2016-2017 Wind River Systems, Inc.
#

FILESEXTRAPATHS_prepend := "${THISDIR}/grub-efi:"

SRC_URI += " \
    file://grub-runtime.cfg \
"

inherit update-alternatives

ALTERNATIVE_PRIORITY = "50"
ALTERNATIVE_${PN} = "grub-editenv grub-fstest grub-menulst2cfg grub-mkimage \
                     grub-mklayout grub-mkpasswd-pbkdf2 grub-mkrelpath \
                     grub-script-check grub-bios-setup grub-ofpathname \
                     grub-probe grub-install"

ALTERNATIVE_LINK_NAME[grub-editenv] = "${bindir}/grub-editenv"
ALTERNATIVE_LINK_NAME[grub-fstest] = "${bindir}/grub-fstest"
ALTERNATIVE_LINK_NAME[grub-menulst2cfg] = "${bindir}/grub-menulst2cfg"
ALTERNATIVE_LINK_NAME[grub-mkimage] = "${bindir}/grub-mkimage"
ALTERNATIVE_LINK_NAME[grub-mklayout] = "${bindir}/grub-mklayout"
ALTERNATIVE_LINK_NAME[grub-mkpasswd-pbkdf2] = "${bindir}/grub-mkpasswd-pbkdf2"
ALTERNATIVE_LINK_NAME[grub-mkrelpath] = "${bindir}/grub-mkrelpath"
ALTERNATIVE_LINK_NAME[grub-script-check] = "${bindir}/grub-script-check"
ALTERNATIVE_LINK_NAME[grub-bios-setup] = "${sbindir}/grub-bios-setup"
ALTERNATIVE_LINK_NAME[grub-ofpathname] = "${sbindir}/grub-ofpathname"
ALTERNATIVE_LINK_NAME[grub-probe] = "${sbindir}/grub-probe"
ALTERNATIVE_LINK_NAME[grub-install] = "${sbindir}/grub-install"

do_install_append_class-target() {
    install -m 0600 "${WORKDIR}/grub-runtime.cfg" "${D}${EFI_BOOT_PATH}/grub.cfg"
}

do_deploy_append_class-target() {
    install -d ${DEPLOYDIR}

    [ -s "${D}${EFI_BOOT_PATH}/grub.cfg.p7b" ] &&
        install -m 0600 "${D}${EFI_BOOT_PATH}/grub.cfg.p7b" "${DEPLOYDIR}"

    install -m 0600 "${D}${EFI_BOOT_PATH}/grub.cfg" "${DEPLOYDIR}"
}

pkg_preinst_${PN} () {
    #!/bin/sh -e
    if [ x"$D" = "x" ]; then
        if [ -f ${bindir}/grub-editenv ]; then
            rm -f ${bindir}/grub-editenv
        fi
        if [ -f ${bindir}/grub-fstest ]; then
            rm -f ${bindir}/grub-fstest
        fi
        if [ -f ${bindir}/grub-menulst2cfg ]; then
            rm -f ${bindir}/grub-menulst2cfg
        fi
        if [ -f ${bindir}/grub-mkimage ]; then
            rm -f ${bindir}/grub-mkimage
        fi
        if [ -f ${bindir}/grub-mklayout ]; then
            rm -f ${bindir}/grub-mklayout
        fi
        if [ -f ${bindir}/grub-mkpasswd-pbkdf2 ]; then
            rm -f ${bindir}/grub-mkpasswd-pbkdf2
        fi
        if [ -f ${bindir}/grub-mkrelpath ]; then
            rm -f ${bindir}/grub-mkrelpath
        fi
        if [ -f ${bindir}/grub-script-check ]; then
            rm -f ${bindir}/grub-script-check
        fi
        if [ -f ${sbindir}/grub-bios-setup ]; then
            rm -f ${sbindir}/grub-bios-setup
        fi
        if [ -f ${sbindir}/grub-ofpathname ]; then
            rm -f ${sbindir}/grub-ofpathname
        fi
        if [ -f ${sbindir}/grub-probe ]; then
            rm -f ${sbindir}/grub-probe
        fi
        if [ -f ${sbindir}/grub-install ]; then
            rm -f ${sbindir}/grub-install
        fi
    fi
}

