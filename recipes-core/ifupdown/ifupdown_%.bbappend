pkg_preinst_${PN} () {
    #!/bin/sh -e
    if [ x"$D" = "x" ]; then
        if [ -f ${base_sbindir}/ifup ]; then
            rm -f ${base_sbindir}/ifup
        fi
        if [ -f ${base_sbindir}/ifdown ]; then
            rm -f ${base_sbindir}/ifdown
        fi
    fi
}
