#
# Copyright (C) 2015 Wind River Systems, Inc.
#

DESCRIPTION = "Packagegroup to build RPMs used for samples."

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

WR_MACHINE_ESSENTIAL_EXTRA_RDEPENDS ?= ""
ALLOW_EMPTY_packagegroup-samples = "1"

RDEPENDS_packagegroup-samples += " gcc-example"
RPROVIDES_${PN} = "samples"
