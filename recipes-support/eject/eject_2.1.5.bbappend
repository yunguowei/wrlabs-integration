ALTERNATIVE_${PN}-doc += "eject.1"
ALTERNATIVE_LINK_NAME[eject.1] = "${mandir}/man1/eject.1"

pkg_preinst_${PN}-doc () {
    #!/bin/sh -e
    if [ x"$D" = "x" -a -f ${mandir}/man1/eject.1 ]; then
	rm -f ${mandir}/man1/eject.1
    fi
}

