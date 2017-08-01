#
# Copyright (C) 2017 Wind River Systems, Inc.
#

BBCLASSEXTEND += "nativesdk"

do_install_append_class-nativesdk() {
    for i in `find ${D}${libdir} -name '*.py'`; do
        sed -i -e s:${bindir}/python:/usr/bin/env\ python: $i
    done

    for i in ${D}${bindir}/*; do
        sed -i -e s:${bindir}/env:/usr/bin/env: $i
    done
}

