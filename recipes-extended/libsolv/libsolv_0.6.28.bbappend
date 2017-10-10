FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI_append = " \
    file://0001-repo_rpmdb.c-increase-MAX_HDR_CNT-and-MAX_HDR_DSIZE.patch \
"
