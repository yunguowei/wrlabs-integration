pkg_preinst_${PN} () {
    #!/bin/sh -e
    if [ x"$D" = "x" ]; then
        MOUNT_10_DM_RULES=`mount | grep "10-dm.rules" | awk '{print $3}'`
        if [ X"$MOUNT_10_DM_RULES" != X"" ]; then
            umount $MOUNT_10_DM_RULES
        fi
    fi
}
