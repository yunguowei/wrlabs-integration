pkg_preinst_${PN}-doc () {
    if [ -f ${mandir}/man1/which.1 ]; then
        rm -f ${mandir}/man1/which.1
    fi
}
