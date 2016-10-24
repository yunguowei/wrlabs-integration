
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

SRCREV_machine_xilinx-zynq = "c021b9366e7ebf2ce25d9849936e356b05872e14"
SRCREV_meta_xilinx-zynq = "3c3197e65b6f2f5514853c1fe78ae8ffc131b02c"

SRCREV_machine_intel-corei7-64 = "${@bb.utils.contains('KERNEL_FEATURES', 'leafhill', 'fc5acb0869b95bdc2f9827278b75d6554cebac90', 'c02b86cd8e0c1ee1e3bee2f7344a6086a25c85a7', d)}"
SRCREV_meta_intel-corei7-64 = "3c3197e65b6f2f5514853c1fe78ae8ffc131b02c" 

SRCREV_machine_fsl-ls10xx = "04ca07eded6fad8aed6cdae189a1d377de29c476"
SRCREV_meta_fsl-ls10xx = "3c3197e65b6f2f5514853c1fe78ae8ffc131b02c"

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
