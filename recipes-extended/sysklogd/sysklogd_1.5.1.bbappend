pkg_preinst_${PN}-doc () {
    #!/bin/sh -e
    if [ x"$D" = "x" ]; then
        if [ -f ${mandir}/man8/syslogd.8 ]; then
            rm -f ${mandir}/man8/syslogd.8
        fi
    fi
}
