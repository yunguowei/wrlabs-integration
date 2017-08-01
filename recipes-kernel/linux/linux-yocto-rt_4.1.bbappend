FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

KMACHINE_intel-corei7-64 = "computestick"
KBRANCH_intel-corei7-64 = "standard/preempt-rt/next"

SRCREV_machine ?= "${AUTOREV}"
SRCREV_meta ?= "${AUTOREV}"

EXTRASRCINTL = ""
EXTRASRCINTL_intel-corei7-64 = " \
            file://mm-larger-stack-guard-gap-between-vmas.patch \
"

SRC_URI += "${EXTRASRCINTL}"

SRCREV_machine_intel-corei7-64 = "d4bb1ec950005dc94f707a6fff6e125a6a5d35d0"
SRCREV_meta_intel-corei7-64 = "b28f454e264f24abce6acda7c1c4f05d9a6f7ba5"

LINUX_VERSION = "4.1.33"
LINUX_VERSION_EXTENSION = "-pulsar-${LINUX_KERNEL_TYPE}"

KCONF_AUDIT_LEVEL = "0"

#workaround the issue of the wifi missing ip address
#after a long time without no interaction on computestick.
KERNEL_MODULE_PROBECONF += "iwlmvm"
module_conf_iwlmvm = "options iwlmvm power_scheme=1"

# Combine all linux kernel modules into one rpm package
inherit kernel-module-combine
