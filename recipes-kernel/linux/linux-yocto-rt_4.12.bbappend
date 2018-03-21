
FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

# For the zynq boards we need additional kernel configuration
EXTRASRCZYNQ = ""
EXTRASRCZYNQ_xilinx-zynq = "file://xilinx-zynq-standard.scc"

#KMACHINE_intel-corei7-64 = "computestick"
KBRANCH_intel-corei7-64 = "standard/base"

SRC_URI += "${EXTRASRCZYNQ} \
	file://extra-kernel-feature.scc \
	file://l2tp.scc \
	file://0001-mwifiex-allow-using-network-namespaces.patch \
	file://0001-iwlwifi-disable-the-noisy-warning-on-intel-7260-card.patch \
	file://0001-rsi-uprev-to-1.3.patch \
	file://0002-rsi-add-the-capacity-to-change-network-namespace.patch \
	file://0001-rtlwifi-enable-the-capacity-of-switching-networking-.patch \
"

KBRANCH_xilinx-zynq = "standard/${MACHINE}"
COMPATIBLE_MACHINE_xilinx-zynq = "${MACHINE}"

SRCREV_machine ?= "${AUTOREV}"
SRCREV_meta ?= "${AUTOREV}"

SRCREV_machine_intel-corei7-64 ?= "${AUTOREV}"
SRCREV_meta_intel-corei7-64 ?= "${AUTOREV}"

# While using AUTOREV turn off the kernel version sanity check
deltask kernel_version_sanity_check

LINUX_VERSION_EXTENSION = "-pulsar-${LINUX_KERNEL_TYPE}"

KCONF_AUDIT_LEVEL = "0"

KERNEL_DEVICETREE_xilinx-zynq = "zynq-zc706.dtb \
                     zynq-zc702.dtb \
                     zynq-zc702-base-trd.dtb \
                     zynq-zed.dtb \
                     zynq-picozed.dtb \
                     zynq-mini-itx-adv7511.dtb \
                     zynq-mini-itx-adv7511-pcie.dtb"

# For the fsl-ls10xx boards we need additional kernel configuration
KBRANCH_fsl-ls10xx = "standard/${MACHINE}"
COMPATIBLE_MACHINE_fsl-ls10xx = "${MACHINE}"

KERNEL_DEVICETREE_fsl-ls10xx = "ls1021a-iot.dtb"

KERNEL_EXTRA_ARGS_fsl-ls10xx += "LOADADDR=0x80008000"

#workaround the issue of the wifi missing ip address
#after a long time without no interaction on computestick.
KERNEL_MODULE_PROBECONF += "iwlmvm"
module_conf_iwlmvm = "options iwlmvm power_scheme=1"

KERNEL_MODULE_PROBECONF += "rsi_usb"
module_conf_rsi_usb = "options rsi_usb dev_oper_mode=14"
# Combine all linux kernel modules into one rpm package
inherit kernel-module-combine
