ALTERNATIVE_${PN}-doc += "su.1"
ALTERNATIVE_LINK_NAME[su.1] = "${mandir}/man1/su.1"

pkg_preinst_${PN}-doc () {
    #!/bin/sh -e
    if [ x"$D" = "x" -a -f ${mandir}/man1/su.1 ]; then
        rm -f ${mandir}/man1/su.1
    fi
}

