#
# Copyright (C) 2017 Wind River Systems, Inc.
#

OS_RELEASE_FIELDS += " RELEASE_CODEID"

BB_DONT_CACHE = "1"

RELEASE_CODEID = "${@base_get_metadata_git_revision('${TOPDIR}', None)}"
do_compile[vardepvalue] += "${RELEASE_CODEID}"

do_compile_prepend() {
    RELEASE_CODEID = d.getVar('RELEASE_CODEID', True)
    if not RELEASE_CODEID:
        RELEASE_CODEID = '<unknown>'
    d.setVar('RELEASE_CODEID', RELEASE_CODEID.strip())
}
