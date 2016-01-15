# Experimental recipe for the ADI kernel tree for Xilinx

inherit kernel
require recipes-kernel/linux/linux-yocto.inc

SRC_URI = "git://github.com/analogdevicesinc/linux;protocol=git;nocheckout=1;name=machine;branch=xcomm_zynq"
SRC_URI += "file://cfg/systemd.scc file://cfg/zynq_cfg.scc"

LINUX_VERSION ?= "4.0"
LINUX_VERSION_EXTENSION = "-pulsar-adi"

SRCREV_machine="bf956a3e939e0ff8b419ca52878e457824189819"

PV = "${LINUX_VERSION}+git${SRCPV}"

# Override COMPATIBLE_MACHINE to include your machine in a copy of this recipe
# file. Leaving it empty here ensures an early explicit build failure.
COMPATIBLE_MACHINE = "none"
COMPATIBLE_MACHINE_xilinx-zynq = "${MACHINE}"

KCONF_AUDIT_LEVEL = "0"

KERNEL_EXTRA_ARGS_xilinx-zynq += "LOADADDR=0x8000"

KERNEL_DEVICETREE_xilinx-zynq = "${S}/arch/arm/boot/dts/zynq-zc706.dts \
                     ${S}/arch/arm/boot/dts/zynq-zc702.dts \
                     ${S}/arch/arm/boot/dts/zynq-zed.dts \
                     ${S}/arch/arm/boot/dts/zynq-mini-itx-adv7511.dts"

