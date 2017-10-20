EXTRA_OEMAKE_remove += "\
    OVERRIDE_SECURITY_POLICY=1 \
"

FILES_${PN} = "/boot/efi/EFI/BOOT/bootx64.efi \
               /boot/efi/EFI/BOOT/mmx64.efi \
               "
