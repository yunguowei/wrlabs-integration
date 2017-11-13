# Copyright (C) 2012, 2014, 2015 Wind River Systems, Inc.
# Common functions that are used for report generation

# WR_RPT_ONLY_LAYERS specifies exactly which layers to
#    report.  It takes precedence over WR_RPT_EXCLUDE_LAYERS.
#
# WR_RPT_EXCLUDE_LAYERS lists which layers to not report.
#
# Absent both of these variables, we report everything.
#
def skipLayer(d,layer):
    onlyL = d.getVar('WR_RPT_ONLY_LAYERS', True)
    if onlyL:
        if layer not in onlyL.split():
            return True
    else:
        excludeL = d.getVar('WR_RPT_EXCLUDE_LAYERS', True)
        if excludeL:
            if layer in excludeL.split():
                return True

    return False


# Modified from create_log_file in oe-core to fit the format that we want
# This makes sure the LOG_DIR is made and creates a file that is 
# ${filename}-YYYYMMDD-HHMMSS${filetype} and a symlink that is named:
# ${filename}${filetype}
def create_logfile(d, logname):
    import datetime, errno
    logpath = d.getVar('LOG_DIR', True)
    bb.utils.mkdirhier(logpath)
    logfn, logsuffix = os.path.splitext(logname)
    curtime = datetime.datetime.now().strftime('%G%m%d-%H%M%S')
    logfile = os.path.join(logpath, '%s-%s%s' % (logfn,curtime,logsuffix))
    try:
        os.utime(logfile,None)
    except OSError as err:
        if err.errno == errno.ENOENT:
            # file did not exist, create
            with open(logfile, 'a'):
                pass
        else:
            raise
    slogfile = os.path.join(logpath, logname)
    if os.path.exists(slogfile):
        os.remove(slogfile)
    os.symlink(logfile, slogfile)
    d.setVar('LOG_FILE', logfile)
    return logfile

def Report_Start(d, headers, filenames):
    """
    Make the base reports using a header and filenames.
    """
    import csv
    for name in filenames:
        with open(create_logfile(d, name), 'w') as f:
            writer = csv.writer(f)
            writer.writerow(headers)

# A function that will process metadata that is provided in the recipes.
# It returns a list of data that can be used in the report generators to use 
# what data they need
def Parse_Data(d):
    import re, collections
    Reportdata=collections.namedtuple('Reportdata',
    ['pname', 'pversion', 'latest_ver', 'summary','description','group'
    ,'licence','filename','upstream_loc','subpackage','layer'
    ,'patches','recipe','subdir'])
    pn = d.getVar('PN', True)

    # pkg_regex = '(^(lib32|libx32|libn32|lib64|packagegroup|nativesdk|meta-environment|meta-ide|meta-toolchain)-|-image-|(-native$)|-cross)'
    pkg_regex = '(^(lib32|libx32|libn32|libo32|lib64|packagegroup|meta-environment|meta-ide|meta-toolchain)-|-packagegroup-|-image-|-cross)'
    if not re.search(pkg_regex, pn):
        psumm = d.getVar('SUMMARY', True).replace('\n','')
        pdesc = d.getVar('DESCRIPTION',True).replace('\n','')
        pdesc = re.sub("\s+", " ", pdesc.strip())
        pdesc = re.sub(",", "@COMMA@", pdesc)
        plicense = d.getVar('LICENSE', True)

        filename = []
        location = []
        patches=0
        local_files = []

        # Split up the SRC_URI and work through the list. Count the patches 
        # and indicate if the file is modified. With tarballs use the tarball
        # name and for git and svn files create a tarball name. The git/svn 
        # source will be tarred up under this same name and used as the 
        # source disclosure for the IP group.
        #
        # This code has been adapted for use with the oe-core archiver bbclass
        # when processing git, svn, and hg uri's.  Remnants of the old way of
        # doing things for other cases should probably be removed.
        #
        for i, urlWithParams in enumerate(d.getVar('SRC_URI', True).split()):
            pattern='[/=][-a-zA-Z0-9\.\+_]+\.[tzsrgbalxi]{2}[\.rbz2pglxZcm]{1,5}\Z'
            urlNoParams = urlWithParams.split(';')[0]

            if re.search(r"\.patch|\.diff\.gz|-patches|\.diff", urlWithParams):
                patches+=1
            else:
                try:
                    filename.append(re.findall(pattern,urlNoParams)[0][1:])
                    location.append(urlNoParams)
                except IndexError:
                    fetch = bb.fetch2.Fetch([ urlWithParams ], d)
                    uData = fetch.ud[urlWithParams]

                    if uData.type in ['git', 'gitsm']:
                        # bpn = d.getVar('BPN',True)
                        # We split on '+' to chuck any annoying AUTOINC+ in the revision.
                        src_rev = bb.fetch2.get_srcrev(d).split('+')[-1]
                        location.append(urlNoParams)

                        gitLocal = os.path.basename(uData.localfile)
                        filename.append("%s.%s.tar.gz" % (gitLocal,src_rev))
                    elif uData.type in ['svn','hg']:
                        # bpn = d.getVar('BPN',True)
                        location.append(urlNoParams)

                        filename.append(uData.localfile)

        # filename and location are parallel lists, so if
        # filename is empty, so is location
        #
        if not filename:
            if local_files:
                # bb.warn("%s using local files %s" % (d.getVar('BPN',True), " ".join(local_files)))
                filename.append(("%s-%s-local.tar.bz2" % 
                                (d.getVar('BPN',True),d.getVar('PV',True))))
                location.append('No Download')
            else:
                filename.append(("%s-%s-NO-SOURCE" % 
                                (d.getVar('BPN',True),d.getVar('PV',True))))
                location.append('No Download')

        try:
            plocation = re.findall("layers\/[a-zA-Z0-9-._]+",
                       d.getVar('FILE', True))[0].split('/')[-1]
        except IndexError:
            plocation = d.getVar('FILE', True)

        if skipLayer(d,plocation):
            return None

        try:
            subdir = re.findall("\/recipes-[a-zA-Z-]+",
                       d.getVar('FILE', True))[0].split('/')[-1]
        except IndexError:
            subdir = plocation

        psubpkg = re.sub("\s+", " ", d.getVar('PACKAGES', True).strip())
        if psubpkg is None:
            psubpkg = d.getVar('BPN', True)

        # Note that we return the full recipe path because we need
        # that when doing get_tar.
        #
        return Reportdata(pn,d.getVar('PV',True)
                         ,d.getVar('RECIPE_LATEST_VERSION',True),psumm
                         ,pdesc,d.getVar('SECTION',True),plicense
                         ,filename,location,psubpkg,plocation,patches
                         ,d.getVar('FILE', True), subdir)

# This is meant to be run manually after something like ar_original.  We cannot
# use deploy_archives from the archiver bbclass because it only allows one version
# of a package to be deployed.
#
# Technically, we should probably inherit archiver and be in our own bbclass,
# but this is special purpose stuff, so we just put it here.
#
do_wr_deploy_archives () {
    echo "Deploying ${ARCHIVER_TOPDIR} to ${DEPLOY_DIR_SRC}"
    mkdir -p ${DEPLOY_DIR_SRC}
    cp -r ${ARCHIVER_TOPDIR}/* ${DEPLOY_DIR_SRC}
}

addtask do_wr_deploy_archives

