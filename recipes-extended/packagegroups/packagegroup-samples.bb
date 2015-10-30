#
# Copyright (C) 2015 Wind River Systems, Inc.
#

DESCRIPTION = "Packagegroup to build RPMs used for samples."

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/LICENSE;md5=4d92cd373abda3937c2bc47fbc49d690"

WR_MACHINE_ESSENTIAL_EXTRA_RDEPENDS ?= ""
ALLOW_EMPTY_packagegroup-samples = "1"

RDEPENDS_packagegroup-samples += " gcc-example"
RPROVIDES_${PN} = "samples"
