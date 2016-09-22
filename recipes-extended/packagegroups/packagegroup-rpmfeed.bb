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

WRL_RPM_FEED_EXTRAS_intel-corei7-64 += " \
    google-chrome-stable  \
    firefox-stable \
    dpdk \
    dpdk-examples \
"

#
#There is license issue for iiot-demo,
#So just comment it out, once the license
#issue resolved, uncomment it.
#WRL_RPM_FEED_EXTRAS_xilinx-zynq += " \
#    iiot-demo \
#"

RDEPENDS_${PN} += "${WRL_RPM_FEED_EXTRAS}"

