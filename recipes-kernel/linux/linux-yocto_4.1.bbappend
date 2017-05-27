
FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

# For the zynq boards we need additional kernel configuration
EXTRASRCZYNQ = ""
EXTRASRCZYNQ_xilinx-zynq = " \
            file://xilinx-zynq-extra.scc \
            file://xilinx-zynq-extra.cfg \
          "

EXTRASRCTPMSEC = ""
EXTRASRCTPMSEC_intel-corei7-64 = " \
            file://tpm-sec.scc \
            file://tpm-sec.cfg \
          "

SRC_URI += "${EXTRASRCZYNQ} ${EXTRASRCTPMSEC}"

KMACHINE_intel-corei7-64 = "${@bb.utils.contains('BSP_SUBTYPE', 'apollolake', 'apollolake', 'computestick', d)}"
KBRANCH_intel-corei7-64 = "${@bb.utils.contains('BSP_SUBTYPE', 'apollolake', 'standard/intel/4.1.27/leaf-hill', 'standard/next', d)}"

KBRANCH_xilinx-zynq = "standard/${MACHINE}"
COMPATIBLE_MACHINE_xilinx-zynq = "${MACHINE}"

SRCREV_machine ?= "${AUTOREV}"
SRCREV_meta ?= "${AUTOREV}"

SRCREV_machine_xilinx-zynq = "b84fa289e6f61b8788aae85f81dcd52c9f69cb56"
SRCREV_meta_xilinx-zynq = "b28f454e264f24abce6acda7c1c4f05d9a6f7ba5"

SRCREV_machine_intel-corei7-64 = "${@bb.utils.contains('BSP_SUBTYPE', 'apollolake', '435c0950fd5b89eba02860a3aadc85b8247a5ff9', '6f5b20efc9ddb8823b0af991e94af91eee44df86', d)}"
SRCREV_meta_intel-corei7-64 = "46b3153a39950b3542a99486bd964ab2ed65aeb4" 

SRCREV_machine_fsl-ls10xx = "bdb829c36f5c6a1f1a158967d82a88e2d71ac5c8"
SRCREV_meta_fsl-ls10xx = "b28f454e264f24abce6acda7c1c4f05d9a6f7ba5"

LINUX_VERSION_intel-corei7-64 = "${@bb.utils.contains('BSP_SUBTYPE', 'apollolake', '4.1.27', '4.1.33', d)}"

LINUX_VERSION_EXTENSION = "-pulsar-${LINUX_KERNEL_TYPE}"

KCONF_AUDIT_LEVEL = "0"

KERNEL_DEVICETREE_xilinx-zynq = "zynq-zc706.dtb \
                     zynq-zc702.dtb \
                     zynq-zc702-base-trd.dtb \
                     zynq-zed.dtb \
                     zynq-microzed-iiot.dtb \
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

# Combine all linux kernel modules into one rpm package
inherit kernel-module-combine
