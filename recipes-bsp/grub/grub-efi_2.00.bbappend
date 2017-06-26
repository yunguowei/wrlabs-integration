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

