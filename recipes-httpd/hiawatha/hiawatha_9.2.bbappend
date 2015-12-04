#
# Copyright (C) 2015 Wind River Systems, Inc.
#

do_install_append(){
    if [ -d ${D}${localstatedir}/run ]; then
        rmdir "${D}${localstatedir}/run"
    fi
}
