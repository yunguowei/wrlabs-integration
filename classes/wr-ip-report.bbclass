# Copyright (C) 2012 Wind River Systems, Inc.
# This is used by inheriting wr-ip-report or using --with-template=feature/ip-report
# which will inherit wr-ip-report and generate a report while configuring

inherit wr-report

def runs_on_host(pkg):
    import re
    """
    Return True if the given package is intended to run
    on the host (build) system, False if it's supposed
    to run on the target (built-for) system.
    """
    # Names that begin with native-, cross-, or initial-
    # or have those embedded (...-native, ...-cross, ...-initial
    # or ...-native-... etc) are Host, others are Target.
    return re.search('(^|-)(native|cross|initial)(-|$)', pkg) is not None

def simplified_report(target_file_path, lst,header):
    import operator, csv
    """
    Make simplified report using "both" word.
    """
    with open(target_file_path, 'w') as stream:
        writer = csv.writer(stream)
        # Loop below requires nonempty list.
        if len(lst):
            # Create list so the output can be sorted alphabetically by 
            # package name instead of by filename
            uniquel = []
            
            it = iter(sorted(lst,key=operator.itemgetter(0,1)))
            Current = next(it)

            # Iterate through the list and compare the current item to the 
            # next one. If they have the same filename and either package
            # name is in the other check to see if they are run on different
            # target, if they are change to Both.
            for Next in it:
                pfname1, pname1 = Current[0],Current[1]
                pfname2, pname2 = Next[0],Next[1]
                if pfname1 == pfname2 and (pname1 in pname2 or
                                           pname2 in pname1):
                    if Current[4] != Next[4]:
                        Current[4] = 'Both'
                else:
                    uniquel.append(Current)
                    Current = Next
            uniquel.append(Current)
            writer.writerow(header)
            writer.writerows(sorted(uniquel,key=operator.itemgetter(1)))

def disclosed_by(layer):
    leads = { 'oe-core': 'Randy MacLeod', 'meta-selinux': 'Joe MacDonald',
              'wr-base': 'Randy MacLeod', 'meta-networking': 'Joe MacDonald',
              'wrlabs-integration': 'Fupan Li', 'meta-gateway': 'Fupan Li',
              'meta-overc': 'Fupan Li',  'meta-java': 'Fupan Li',
              'meta-webserver': 'Joe MacDonald', 'wr-kernel': 'Bruce Ashfield' }
    if layer in leads:
        return leads[layer]
    else:
        return 'Unknown'

python run_ip_report() { 
    import csv
    import bb.cooker

    layers = ['wrlabs-integration', 'meta-gateway', 'meta-overc', 'meta-java']

    # When the parse is started, create the base report with the header with a
    # symlink to a timestamped file
    if isinstance(e, bb.event.ParseStarted):
        Report_Start(e.data,
            ['Package File Name', 'Package Name', 'Version', 'SHA1', 'Disclosed By',
                'Description',
                'Part Of (Runtime,Host,Both)',
                'Shipped As (Source,Binary,Both)', 'Modified (Yes,No)',
                'Hardware Interfacing (Yes,No)',
                'Subsystem', 'License(s) Found', 'Package Download URL',
                'Notes'],
            ['IP-report.csv', 'IP-report-full.csv'])

    # When a recipe is completely parsed, pass the data to the Parse_Data fuction
    # to return metadata that is required and write the rows that are needed for
    # the report
    if isinstance(e, bb.event.RecipeParsed):
        logfile = os.path.join(e.data.getVar('LOG_DIR', True)
                              , "IP-report-full.csv")

        l=Parse_Data(e.data)

        if l is not None:
            if l.layer not in layers:
                return
            with open(logfile,'a') as f:
                for file,location in zip(l.filename,l.upstream_loc):
                    # The number and order of these values must match those
                    # given to Report_Start() as column headers.
                    #
                    csv.writer(f).writerow([file,l.pname,l.pversion, l.recipe, disclosed_by(l.layer)
                               ,l.summary
                               ,'Host' if runs_on_host(l.pname) else 'Runtime'
                               ,'Source',('yes' if l.patches else 'no')
                               ,'No',l.layer,l.licence
                               ,location,''])

    if isinstance(e, bb.event.ParseCompleted):
         # Sort the full list by the package name and output the sorted list.
        import operator
        logpath = e.data.getVar('LOG_DIR', True)
        report = os.path.join(logpath, "IP-report.csv")
        full_report = os.path.join(logpath, "IP-report-full.csv")
        with open(full_report, 'r') as f:
            csvinfile = csv.reader(f, delimiter=',')
            header = next(csvinfile)
            csvlistform = list(csvinfile)

        with open(full_report,'w') as f:
            writer = csv.writer(f)
            writer.writerow(header)
            writer.writerows(sorted(csvlistform,
                key = operator.itemgetter(1)))


        simplified_report(report,csvlistform, header)

    # Remove the cache when the Cooker is finished so a report will be 
    # generated every time bitbake is run
    #if isinstance(e, bb.cooker.CookerExit):
    #    import shutil
    #    cachedir = os.path.join(e.data.getVar("TMPDIR",True),'cache')
    #    if os.path.exists(cachedir):
    #        shutil.rmtree(cachedir)
}

# Add run_ip_report as a handler to be run by bitbake
addhandler run_ip_report
run_ip_report[eventmask] = "bb.event.ParseStarted bb.event.RecipeParsed bb.event.ParseCompleted"
