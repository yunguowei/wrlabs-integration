
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

SRCREV_machine_xilinx-zynq = "07d10826bf8242c43e304e07c168858117100774"
SRCREV_meta_xilinx-zynq = "0d6de63d4603b9cc3a4a68391bcb5156b9b0cf96"

SRCREV_machine_intel-corei7-64 = "de4decd7e11b0e5a895765f88b8a471116473243"
SRCREV_meta_intel-corei7-64 = "0d6de63d4603b9cc3a4a68391bcb5156b9b0cf96"

SRCREV_machine_fsl-ls10xx = "1ed4f983fe8cb304570bab041621c209d55c0883"
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
