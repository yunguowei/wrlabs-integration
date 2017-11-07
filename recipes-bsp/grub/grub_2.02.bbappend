
inherit update-alternatives

ALTERNATIVE_PRIORITY = "100"
ALTERNATIVE_${PN} = "grub-fstest grub-menulst2cfg grub-mkimage \
                     grub-mklayout grub-mkpasswd-pbkdf2 grub-mkrelpath \
                     grub-script-check grub-bios-setup grub-ofpathname \
                     grub-probe grub-install grub-file grub-glue-efi \
		     grub-mknetdir grub-mkrescue grub-mkstandalone grub-render-label \
		     grub-syslinux2cfg grub-macbless grub-sparc64-setup "

ALTERNATIVE_grub-editenv = "grub-editenv"

FILES_${PN}-editenv = "${bindir}/grub-editenv ${bindir}/grub-editenv.grub"

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
