#
# Copyright (C) 2015 Wind River Systems, Inc.
#

FILESPATH_append := ":${@base_set_filespath(['${THISDIR}'], d)}/${PN}"
SRC_URI += "file://smartpm-add-a-builddep-command-to-install-all-of-the.patch \
            file://0001-add-the-user-password-input-function-for-https-basic.patch \
	    file://python-smartpm-fix-the-bug-of-ssl-certificate-verify.patch \
	    file://0001-smartpm-make-smart-send-system-id-to-rpm-repo-server.patch \
	    file://0001-smartpm-catch-the-network-unreachable-error-and-exit.patch \
	    file://smartpm-Secure-Shield-enabled-for-smart.patch \
	    file://0001-smartpm-add-an-extra-query-string-to-smart-channel-u.patch \
           "
# Add the option to change the data-dir to '/usr/lib/smart/data-dir'
PACKAGECONFIG[change-data-dir] = ",,,"
OVERRIDES .= "${@['', ':CHG-DATA-DIR']['change-data-dir' in d.getVar('PACKAGECONFIG', True).split()]}"
SRC_URI_append_CHG-DATA-DIR = "file://python-smartpm-change-the-smart-data-dir-to-usr-lib-.patch"
