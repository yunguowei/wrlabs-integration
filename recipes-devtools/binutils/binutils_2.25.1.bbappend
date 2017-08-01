inherit update-alternatives

ALTERNATIVE_${PN}-doc += "bfd.info"
ALTERNATIVE_LINK_NAME[bfd.info] = "${infodir}/bfd.info"

pkg_preinst_${PN}-doc () {
    #!/bin/sh -e
    if [ x"$D" = "x" -a -f ${infodir}/bfd.info ]; then
        rm -f ${infodir}/bfd.info
    fi
}
