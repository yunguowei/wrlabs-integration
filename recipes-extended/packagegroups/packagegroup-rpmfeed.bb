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
    packagegroup-webserver \
    packagegroup-xfce-desktop \
"

# If using meta-gateway add nodejs and mosquitto

RDEPENDS_${PN} += "${@bb.utils.contains('BBFILE_COLLECTIONS','metagw','nodejs mosquitto','',d)}"

# fsl-ls10xx specific packages
WRL_RPM_FEED_EXTRAS ?= ""

RDEPENDS_${PN} += "${WRL_RPM_FEED_EXTRAS}"

