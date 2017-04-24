pkg_preinst_${PN}-doc () {
    #!/bin/sh -e
    if [ x"$D" = "x" ]; then
        if [ -f ${mandir}/man1/which.1 ]; then
            rm -f ${mandir}/man1/which.1
        fi
    fi
}
