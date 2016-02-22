inherit update-alternatives
ALTERNATIVE_PRIORITY_${PN}-doc = "300"
ALTERNATIVE_${PN}-doc = "standards.info"

ALTERNATIVE_LINK_NAME[standards.info] = "${infodir}/standards.info"
