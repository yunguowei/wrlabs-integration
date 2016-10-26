
FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

# For the zynq boards we need additional kernel configuration
EXTRASRCZYNQ = ""
EXTRASRCZYNQ_xilinx-zynq = " \
            file://xilinx-zynq-extra.scc \
            file://xilinx-zynq-extra.cfg \
          "

SRC_URI += "${EXTRASRCZYNQ}"

KMACHINE_intel-corei7-64 = "${@bb.utils.contains('KERNEL_FEATURES', 'leafhill', 'leafhill', 'computestick', d)}"
KBRANCH_intel-corei7-64 = "${@bb.utils.contains('KERNEL_FEATURES', 'leafhill', 'standard/intel/4.1.27/leaf-hill', 'standard/next', d)}"

KBRANCH_xilinx-zynq = "standard/${MACHINE}"
COMPATIBLE_MACHINE_xilinx-zynq = "${MACHINE}"

SRCREV_machine ?= "${AUTOREV}"
SRCREV_meta ?= "${AUTOREV}"

SRCREV_machine_xilinx-zynq = "e3e46ef41c8e0e2bfac56f96d61bd452e3b49f81"
SRCREV_meta_xilinx-zynq = "ef0d81be621a3e1f75b5fbc8fe97617b5679b7a0"

SRCREV_machine_intel-corei7-64 = "${@bb.utils.contains('KERNEL_FEATURES', 'leafhill', 'fc5acb0869b95bdc2f9827278b75d6554cebac90', '6f5b20efc9ddb8823b0af991e94af91eee44df86', d)}"
SRCREV_meta_intel-corei7-64 = "ef0d81be621a3e1f75b5fbc8fe97617b5679b7a0" 

SRCREV_machine_fsl-ls10xx = "04ca07eded6fad8aed6cdae189a1d377de29c476"
SRCREV_meta_fsl-ls10xx = "ef0d81be621a3e1f75b5fbc8fe97617b5679b7a0"

LINUX_VERSION_intel-corei7-64 = "${@bb.utils.contains('KERNEL_FEATURES', 'leafhill', '4.1.27', '4.1.33', d)}"

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
