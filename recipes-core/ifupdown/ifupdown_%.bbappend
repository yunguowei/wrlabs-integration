pkg_preinst_${PN} () {
    if [ -f ${base_sbindir}/ifup ]; then
        rm -f ${base_sbindir}/ifup
    fi
    if [ -f ${base_sbindir}/ifdown ]; then
        rm -f ${base_sbindir}/ifdown
    fi
}
