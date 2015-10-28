DESCRIPTION = "The Pulsar gcc compile example test cases"
SECTION = "GCC Example Test"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/LICENSE;md5=4d92cd373abda3937c2bc47fbc49d690"
PACKAGES = "gcc-example"
RDEPENDS_${PN} += "gcc g++"

S="${WORKDIR}"

SRC_URI = "file://samples-1.0.tgz \
           "

do_install () {
	install -d ${D}/opt/
	cp -a ${S}/samples ${D}/opt/
}

FILES_${PN} = "/opt/samples"
