#
# Copyright (C) 2015 Wind River Systems, Inc.
#

DESCRIPTION = "Packagegroup to build RPMs used for webserver."

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/LICENSE;md5=4d92cd373abda3937c2bc47fbc49d690"

WR_MACHINE_ESSENTIAL_EXTRA_RDEPENDS ?= ""
ALLOW_EMPTY_packagegroup-webserver = "1"

RDEPENDS_packagegroup-webserver += " apache2 cherokee hiawatha monkey nginx \
				     nostromo sthttpd phpmyadmin xdebug \
				     fcgi spawn-fcgi webmin"
RPROVIDES_${PN} = "webserver"
