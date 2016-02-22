inherit update-alternatives
ALTERNATIVE_PRIORITY_${PN}-doc = "200"
ALTERNATIVE_${PN}-doc = "su.1 nologin.8"

ALTERNATIVE_LINK_NAME[su.1] = "${mandir}/man1/su.1"
ALTERNATIVE_LINK_NAME[nologin.8] = "${mandir}/man8/nologin.8"
