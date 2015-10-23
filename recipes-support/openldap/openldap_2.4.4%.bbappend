
# Patch the do_configure to work with multiple versions of libtool

do_configure() {
    cp ${STAGING_DATADIR_NATIVE}/libtool/*/ltmain.sh ${S}/build
    rm -f ${S}/libtool
    aclocal
    libtoolize --force --copy
    gnu-configize
    autoconf
    oe_runconf
}

