HAC_SDKVERSION = "8.6.0.1"
HAC_SDKNAME = "pulsar8_${MACHINE}"
HAC_SERVER = "app.cloud.windriver.com"

HAC_SDKVERSION_intel-corei7-64 = "8.6.0.1"
HAC_SDKNAME_intel-corei7-64 = "pulsar8_x86"

HAC_SDKVERSION_valleyisland-64 = "8.6.0.1"
HAC_SDKNAME_valleyisland-64 = "pulsar8_x86"

HAC_SDKVERSION_xilinx-zynq = "8.6.0.1"
HAC_SDKNAME_xilinx-zynq = "pulsar8_zedboard"

do_install_append() {
	install -d ${D}/etc/default
	echo ${HAC_SDKVERSION} > ${D}/etc/default/sdkVersion.txt
	echo ${HAC_SDKNAME} > ${D}/etc/default/sdkName.txt
	echo ${HAC_SERVER} > ${D}/etc/default/hacServer.cfg
}
