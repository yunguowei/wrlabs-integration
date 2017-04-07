RPROVIDES_${PN}-telnet = "telnet"
RPROVIDES_${PN}-rsh = "rsh"

pkg_preinst_${PN}-doc () {
    if [ -f ${mandir}/man1/hostname.1 ]; then
        rm -f ${mandir}/man1/hostname.1
    fi
    if [ -f ${mandir}/man1/dnsdomainname.1 ]; then
        rm -f ${mandir}/man1/dnsdomainname.1
    fi
    if [ -f ${mandir}/man1/logger.1 ]; then
        rm -f ${mandir}/man1/logger.1
    fi
    if [ -f ${mandir}/man8/syslogd.8 ]; then
        rm -f ${mandir}/man8/syslogd.8
    fi
}
