DESCRIPTION = "This package provide the sensors demo programs."
LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/GPL-2.0;md5=801f80980d171dd6425610833a22dbe6"

do_configure[noexec] = "1"

SRC_URI = "file://hts221_sensor.c  \
	   file://lng2dm_sensor.c  \
	   file://lps22hb_sensor.c \
	   "
S = "${WORKDIR}"

do_compile () {
    $CC $CFLGAS -o hts221_sensor hts221_sensor.c 
    $CC $CFLGAS -o lng2dm_sensor lng2dm_sensor.c
    $CC $CFLGAS -o lps22hb_sensor lps22hb_sensor.c
}

do_install () {
    install -d ${D}/opt/sensors-demo
    install -m 0755 hts221_sensor ${D}/opt/sensors-demo
    install -m 0755 lng2dm_sensor ${D}/opt/sensors-demo 
    install -m 0755 lps22hb_sensor ${D}/opt/sensors-demo
}

FILES_${PN} += "/opt"
