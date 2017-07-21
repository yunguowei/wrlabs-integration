FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI_append = " \
    file://0001-rpm-disable-the-debug-to-ignore-the-tons-of-error-in.patch \
    file://0001-rpm-remove-the-retry-debug-info.patch \
"

