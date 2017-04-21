#
# Copyright (C) 2016-2017 Wind River Systems, Inc.
#

FILESEXTRAPATHS_prepend := "${THISDIR}/grub-efi:"

SRC_URI += " \
    file://grub-runtime.cfg \
"

ALTERNATIVE_PRIORITY = "50"
ALTERNATIVE_${PN} = "grub-editenv grub-fstest grub-menulst2cfg grub-mkimage \
                     grub-mklayout grub-mkpasswd-pbkdf2 grub-mkrelpath \
                     grub-script-check grub-bios-setup grub-ofpathname \
                     grub-probe grub-install"

ALTERNATIVE_TARGET[grub-editenv] = "${bindir}/grub-editenv"
ALTERNATIVE_TARGET[grub-fstest] = "${bindir}/grub-fstest"
ALTERNATIVE_TARGET[grub-menulst2cfg] = "${bindir}/grub-menulst2cfg"
ALTERNATIVE_TARGET[grub-mkimage] = "${bindir}/grub-mkimage"
ALTERNATIVE_TARGET[grub-mklayout] = "${bindir}/grub-mklayout"
ALTERNATIVE_TARGET[grub-mkpasswd-pbkdf2] = "${bindir}/grub-mkpasswd-pbkdf2"
ALTERNATIVE_TARGET[grub-mkrelpath] = "${bindir}/grub-mkrelpath"
ALTERNATIVE_TARGET[grub-script-check] = "${bindir}/grub-script-check"
ALTERNATIVE_TARGET[grub-bios-setup] = "${sbindir}/grub-bios-setup"
ALTERNATIVE_TARGET[grub-ofpathname] = "${sbindir}/grub-ofpathname"
ALTERNATIVE_TARGET[grub-probe] = "${sbindir}/grub-probe"
ALTERNATIVE_TARGET[grub-install] = "${sbindir}/grub-install"

do_install_append_class-target() {
    install -m 0600 "${WORKDIR}/grub-runtime.cfg" "${D}${EFI_BOOT_PATH}/grub.cfg"
}

do_deploy_append_class-target() {
    install -d ${DEPLOYDIR}

    install -m 0600 "${D}${EFI_BOOT_PATH}/grub.cfg" "${DEPLOYDIR}"
    [ -s "${D}${EFI_BOOT_PATH}/grub.cfg.p7b" ] &&
        install -m 0600 "${D}${EFI_BOOT_PATH}/grub.cfg.p7b" "${DEPLOYDIR}"
}
