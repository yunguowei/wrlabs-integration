#
# Copyright (C) 2017 Wind River Systems, Inc.
#

RDEPENDS_${PN} += "\
    nativesdk-rpm-build \
    nativesdk-createrepo \
    nativesdk-gnupg \
    ${@bb.utils.contains('DISTRO_FEATURES', 'ima', 'nativesdk-ima-evm-utils', '', d)} \
    nativesdk-libxml2-python \
    nativesdk-rpm-tool \
    "
