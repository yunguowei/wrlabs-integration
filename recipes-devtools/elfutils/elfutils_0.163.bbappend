FILESPATH_append := ":${@base_set_filespath(['${THISDIR}'], d)}/${PN}"

SRC_URI += " \
    file://0001-libebl-Fix-missing-brackets-around-if-statement-body.patch \
    file://0001-Remove-redundant-NULL-tests.patch \
"
