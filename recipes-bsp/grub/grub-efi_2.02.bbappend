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
                     grub-probe grub-install grub-file grub-glue-efi \
                     grub-mknetdir grub-mkrescue grub-mkstandalone grub-render-label \
                     grub-syslinux2cfg grub-macbless grub-sparc64-setup "

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
ALTERNATIVE_LINK_NAME[grub-file] = "${bindir}/grub-file"
ALTERNATIVE_LINK_NAME[grub-glue-efi] = "${bindir}/grub-glue-efi"
ALTERNATIVE_LINK_NAME[grub-mknetdir] = "${bindir}/grub-mknetdir"
ALTERNATIVE_LINK_NAME[grub-mkrescue] = "${bindir}/grub-mkrescue"
ALTERNATIVE_LINK_NAME[grub-mkstandalone] = "${bindir}/grub-mkstandalone"
ALTERNATIVE_LINK_NAME[grub-render-label] = "${bindir}/grub-render-label"
ALTERNATIVE_LINK_NAME[grub-syslinux2cfg] = "${bindir}/grub-syslinux2cfg"
ALTERNATIVE_LINK_NAME[grub-macbless] = "${sbindir}/grub-macbless"
ALTERNATIVE_LINK_NAME[grub-sparc64-setup] = "${sbindir}/grub-sparc64-setup"

EFI_BOOT_PATH = "/boot/efi/EFI/BOOT"

do_install_append_class-target() {
    install -d ${D}${EFI_BOOT_PATH}
    install -m 0600 "${WORKDIR}/grub-runtime.cfg" "${D}${EFI_BOOT_PATH}/grub.cfg"
}

do_deploy_append_class-target() {
    install -d ${DEPLOYDIR}

    if [ "${@bb.utils.contains('DISTRO_FEATURES', 'efi-secure-boot', '1', '0', d)}" = "1" ]; then 
        install -m 0600 "${D}${EFI_BOOT_PATH}/grub.cfg.p7b" "${DEPLOYDIR}"
    fi

    install -m 0600 "${D}${EFI_BOOT_PATH}/grub.cfg" "${DEPLOYDIR}"
   
    efi_target=`echo ${GRUB_IMAGE} | sed 's/^grub-efi-//'` 

    if [ "${@bb.utils.contains('DISTRO_FEATURES', 'efi-secure-boot', '1', '0', d)}" = "0" ]; then
        install -m 644 ${B}/${GRUB_IMAGE} ${D}${EFI_BOOT_PATH}/${efi_target}
    fi
}

FILES_${PN} += "${EFI_BOOT_PATH}"

addtask  deploy after do_install before do_package

python __anonymous() {
    d.setVarFlag('do_deploy', "fakeroot", "1")
}
