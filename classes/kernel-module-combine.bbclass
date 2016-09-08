# Combine all kernel modules into one kernel-module rpm package
python split_kernel_module_packages_append () {
    if d.getVar('KERNEL_MODULE_COMBINED_PACKAGE', True) == "1":
        if modules:
            metapkg = d.getVar('KERNEL_MODULES_META_PACKAGE', True)
            rdeps = " " + d.getVar('RDEPENDS_%s' % metapkg, True) + " "
            pkgs = " " + d.getVar('PACKAGES', True) + " "
            rprovides = " "
            files = " "
            pkgv = d.getVar('PKGV', True)
            pkgv = pkgv.replace("-", "+")
            pkgr = d.getVar('PKGR', True)

            for m in modules:
                pkgs = pkgs.replace(" " + m + " ", " ")
                rprovides = rprovides + " %s (= %s-%s)" % (m, pkgv, pkgr)
                files = files + ' ' + d.getVar('FILES_%s' % m, True)
                rdeps = rdeps + d.getVar('RDEPENDS_%s' % m, True) + " "

            for m in modules:
                while rdeps.find(" " + m + " ") != -1:
                    rdeps = rdeps.replace(" " + m + " ", " ")

            d.appendVar('RPROVIDES_%s' % metapkg, rprovides)
            d.appendVar('FILES_%s' % metapkg, files)
            d.setVar('PACKAGES', pkgs[1:-1])
            d.setVar('RDEPENDS_%s' % metapkg, rdeps[1:-1])

            postinst = d.getVar('pkg_postinst_modules', True)
            if postinst:
                postinst = '#!/bin/sh\n' + postinst + '\n'
                d.setVar('pkg_postinst_%s' % metapkg, postinst)

            postrm = d.getVar('pkg_postrm_modules', True)
            if postrm:
                postrm = '#!/bin/sh\n' + postrm + '\n'
                d.setVar('pkg_postrm_%s' % metapkg, postrm)
}
