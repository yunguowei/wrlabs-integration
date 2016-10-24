FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

KMACHINE_intel-corei7-64 = "computestick"
KBRANCH_intel-corei7-64 = "standard/preempt-rt/next"

SRCREV_machine ?= "${AUTOREV}"
SRCREV_meta ?= "${AUTOREV}"

SRCREV_machine_intel-corei7-64 = "9651dc3aad673845b34fcd5b4fa23e61e5dc4732"
SRCREV_meta_intel-corei7-64 = "3c3197e65b6f2f5514853c1fe78ae8ffc131b02c"

LINUX_VERSION = "4.1.33"
LINUX_VERSION_EXTENSION = "-pulsar-${LINUX_KERNEL_TYPE}"

KCONF_AUDIT_LEVEL = "0"

#workaround the issue of the wifi missing ip address
#after a long time without no interaction on computestick.
KERNEL_MODULE_PROBECONF += "iwlmvm"
module_conf_iwlmvm = "options iwlmvm power_scheme=1"

# Combine all linux kernel modules into one rpm package
inherit kernel-module-combine
