inherit update-alternatives
ALTERNATIVE_PRIORITY_${PN}-doc = "200"
ALTERNATIVE_${PN}-doc = "bfd.info configure.info standards.info"

ALTERNATIVE_LINK_NAME[bfd.info] = "${infodir}/bfd.info"
ALTERNATIVE_LINK_NAME[configure.info] = "${infodir}/configure.info"
ALTERNATIVE_LINK_NAME[standards.info] = "${infodir}/standards.info"
