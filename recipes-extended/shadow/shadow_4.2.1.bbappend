ALTERNATIVE_${PN}-doc += "su.1 nologin.8"
ALTERNATIVE_LINK_NAME[su.1] = "${mandir}/man1/su.1"
ALTERNATIVE_LINK_NAME[nologin.8] = "${mandir}/man8/nologin.8"

pkg_preinst_${PN}-doc () {
    #!/bin/sh -e
    if [ x"$D" = "x" -a -f ${mandir}/man1/su.1 ]; then
        rm -f ${mandir}/man1/su.1
    fi
    if [ x"$D" = "x" -a -f ${mandir}/man8/nologin.8 ]; then
        rm -f ${mandir}/man8/nologin.8
    fi
}

