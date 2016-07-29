
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

SRCREV_machine_xilinx-zynq = "16b67c2aaebbb8879edad493f2f74846c0ae6b96"
SRCREV_meta_xilinx-zynq = "0d6de63d4603b9cc3a4a68391bcb5156b9b0cf96"

SRCREV_machine_intel-corei7-64 = "db3fd60cab90469ba89bed1414d279858feff45b"
SRCREV_meta_intel-corei7-64 = "0d6de63d4603b9cc3a4a68391bcb5156b9b0cf96"

SRCREV_machine_fsl-ls10xx = "f7fa5d7f9585d72599e4e4a819bbc4b832e25f7c"
SRCREV_meta_fsl-ls10xx = "0d6de63d4603b9cc3a4a68391bcb5156b9b0cf96"

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

KERNEL_DEVICETREE_fsl-ls10xx = "ls1021a-iot.dtb"

KERNEL_EXTRA_ARGS_fsl-ls10xx += "LOADADDR=0x80008000"

# Combine all linux kernel modules into one rpm package
inherit kernel-module-combine
