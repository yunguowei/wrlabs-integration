
inherit update-alternatives

ALTERNATIVE_PRIORITY = "100"
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
