SUMMARY = "A tool for visualizing changes in Linux software packages"
HOMEPAGE = "https://lvc.github.io/pkgdiff"
LICENSE = "GPLv2+"
LIC_FILES_CHKSUM = "file://LICENSE;md5=917e0347010320df8c8ac79f10aa7e6c"

SRC_URI = "git://github.com/lvc/pkgdiff.git"
SRC_URI += "file://0001-wrl-patch-to-only-concern-the-real-change.patch;striplevel=1"
PATCHTOOL = "git"

SRCREV = "1cf0a88c45d9196b0a1cc1a64438b86d5fe8b45c"

S = "${WORKDIR}/git"

BBCLASSEXTEND += "native nativesdk"

#do_configure(){
#    :
#}
