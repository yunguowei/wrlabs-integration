
FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

# For the zynq boards we need additional kernel configuration
EXTRASRCZYNQ = ""
EXTRASRCZYNQ_xilinx-zynq = "file://xilinx-zynq-standard.scc"

SRC_URI += "${EXTRASRCZYNQ}"

KMACHINE_intel-corei7-64 = "computestick"
KBRANCH_intel-corei7-64 = "standard/next"

KBRANCH_xilinx-zynq = "standard/${MACHINE}"
COMPATIBLE_MACHINE_xilinx-zynq = "${MACHINE}"

SRCREV_machine ?= "${AUTOREV}"
SRCREV_meta ?= "${AUTOREV}"

SRCREV_machine_xilinx-zynq = "3a28ed49637ec807df34488c24658b480810f1db"
SRCREV_meta_xilinx-zynq = "9f68667031354532563766a3d04ca8a618e9177a"

SRCREV_machine_intel-corei7-64 = "34b95cf5a882ffc1374fbe069735319fe989a453"
SRCREV_meta_intel-corei7-64 = "9f68667031354532563766a3d04ca8a618e9177a"

LINUX_VERSION = "4.1.22"
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

KERNEL_DEVICETREE_fsl-ls10xx = "${S}/arch/arm/boot/dts/ls1021a-twr.dts \
                     ${S}/arch/arm/boot/dts/ls1021a-iot.dts"

KERNEL_EXTRA_ARGS_fsl-ls10xx += "LOADADDR=0x80008000"

# Combine all linux kernel modules into one rpm package
inherit kernel-module-combine
