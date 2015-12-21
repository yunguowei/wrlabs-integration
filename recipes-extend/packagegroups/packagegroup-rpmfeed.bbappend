# If using meta-gateway add nodejs and mosquitto

RDEPENDS_${PN} += "${@bb.utils.contains('BBFILE_COLLECTIONS','meta-gateway','nodejs mosquitto','',d)}"

# fsl-ls10xx specific packages
WRL_RPM_FEED_EXTRAS ?= ""
WRL_RPM_FEED_EXTRAS_fsl-ls10xx += "${@bb.utils.contains('BBFILE_COLLECTIONS','vendor-proprietary','rtlswitch','',d)}"

RDEPENDS_${PN} += "${WRL_RPM_FEED_EXTRAS}"

