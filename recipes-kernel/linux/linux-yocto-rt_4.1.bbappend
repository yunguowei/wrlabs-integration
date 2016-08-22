FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

KMACHINE_intel-corei7-64 = "computestick"
KBRANCH_intel-corei7-64 = "standard/preempt-rt/next"

SRCREV_machine ?= "${AUTOREV}"
SRCREV_meta ?= "${AUTOREV}"

SRCREV_machine_intel-corei7-64 = "48de65644adb0a01c1cb339bace04268679bddd1"
SRCREV_meta_intel-corei7-64 = "4e8a96ae9f473f7f742c7a3f5eda70639d9813ec"

LINUX_VERSION = "4.1.30"
LINUX_VERSION_EXTENSION = "-pulsar-${LINUX_KERNEL_TYPE}"

KCONF_AUDIT_LEVEL = "0"

#workaround the issue of the wifi missing ip address
#after a long time without no interaction on computestick.
KERNEL_MODULE_PROBECONF += "iwlmvm"
module_conf_iwlmvm = "options iwlmvm power_scheme=1"

# Combine all linux kernel modules into one rpm package
inherit kernel-module-combine
