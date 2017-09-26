DESCRIPTION = "The Pulsar gcc compile example test cases"
SECTION = "GCC Example Test"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"
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
