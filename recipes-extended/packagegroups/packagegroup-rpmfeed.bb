#
# Copyright (C) 2015 Wind River
#

SUMMARY = "All packages for rpm feeds."
DESCRIPTION = "All packages for rpm feeds."
LICENSE = "MIT"

inherit packagegroup

RDEPENDS_${PN} = "\
    cmake \
    docker \
    kernel-dev \
    kernel-devsrc \
    links \
    links-x11 \
    tsocks \
    \
    packagegroup-samples \
    packagegroup-wr-tools-debug \
"
