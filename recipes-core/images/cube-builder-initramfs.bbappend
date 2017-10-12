PACKAGE_EXCLUDE += "kernel-modules"

deploader = ""
deploader_x86-64 = "grub-efi ovmf"
DEPENDS += "${deploader}"
