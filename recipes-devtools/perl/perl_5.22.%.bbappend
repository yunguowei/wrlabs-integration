python split_perl_packages_append () {
    if d.getVar('PERL_MODULE_COMBINED_PACKAGE', True) == "1":
    # Combine all perl-modules packages into one package named as perl-modules
        if packages:
            perlmodpkg = "perl-modules"
            files = " "
            rprovides = " "
            rrecommends = " " + d.getVar('RRECOMMENDS_%s' % perlmodpkg, True) + " "
            rdeps = " " + "perl" + " "
            pkgs = " " + d.getVar('PACKAGES', True) + " "

            for m in packages:
                files = files + ' ' + d.getVar('FILES_%s' % m, True)
                pkgs = pkgs.replace(" " + m + " ", " ")
                rprovides = rprovides + " %s (= ${PKGV}-${PKGR})" % m

            for m in packages:
                while rdeps.find(" " + m + " ") != -1:
                    rdeps = rdeps.replace(" " + m + " ", " ")
                while rrecommends.find(" " + m + " ") != -1:
                    rrecommends = rrecommends.replace(" " + m + " ", " ")

            d.appendVar('RPROVIDES_%s' % perlmodpkg, rprovides)
            d.appendVar('FILES_%s' % perlmodpkg, files)
            d.setVar('PACKAGES', pkgs[1:-1])
            d.setVar('RDEPENDS_%s' % perlmodpkg, rdeps[1:-1])
            d.setVar('RRECOMMENDS_%s' % perlmodpkg, rrecommends[1:-1])
}
