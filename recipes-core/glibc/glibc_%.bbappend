do_poststash_install_cleanup () {
        # Remove all files which do_stash_locale would remove (mv)
        # since that task could have come from sstate and not get run.
        for i in ${bashscripts}; do
            rm -f ${D}${bindir}/$i
        done
        rm -f ${D}${bindir}/localedef
        rm -rf ${D}${datadir}/i18n
        rm -rf ${D}${libdir}/gconv
        rm -rf ${D}/${localedir}
        rm -rf ${D}${datadir}/locale
        if [ "${libdir}" != "${exec_prefix}/lib" ]; then
                # This dir only exists to hold locales
                # rm -rf ${D}${exec_prefix}/lib
                :
        fi
}
