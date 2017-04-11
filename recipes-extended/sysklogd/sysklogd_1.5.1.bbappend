pkg_preinst_${PN}-doc () {
    if [ -f ${mandir}/man8/syslogd.8 ]; then
        rm -f ${mandir}/man8/syslogd.8
    fi
}
