#
# Copyright (C) 2017 Wind River Systems, Inc.
#

OS_RELEASE_FIELDS += " RELEASE_CODEID"
RELEASE_CODEID = ""

do_compile_prepend() {
    path = d.getVar('TOPDIR', True)
    try:
        RELEASE_CODEID,_ = bb.process.run('git rev-parse HEAD', cwd=path)
    except bb.process.ExecutionError:
        RELEASE_CODEID = '<unknown>'
    d.setVar('RELEASE_CODEID', RELEASE_CODEID.strip())
}
