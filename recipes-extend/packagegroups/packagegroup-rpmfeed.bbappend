# If using meta-gateway add nodejs and mosquitto

RDEPENDS_${PN} += "${@bb.utils.contains('BBFILE_COLLECTIONS','meta-gateway','nodejs mosquitto','',d)}"
