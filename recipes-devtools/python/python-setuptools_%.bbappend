#
# Copyright (C) 2017 Wind River Systems, Inc.
#

do_install_append_class-nativesdk() {
    for i in ${D}${bindir}/*; do
        sed -i -e s:${bindir}/env:/usr/bin/env: $i
    done
}

