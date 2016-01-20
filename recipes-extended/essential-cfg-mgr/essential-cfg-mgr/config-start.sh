#!/bin/sh

for d in `ls -d /var/lib/lxc/*/rootfs 2> /dev/null`; do
    if [ -e $d/usr/sbin/device ] ; then
	if [ /boot/device_mgr.cfg -nt $d/etc/default/device_mgr.cfg ] ; then
	    cp /boot/device_mgr.cfg $d/etc/default/device_mgr.cfg
	    fi
	break
	fi
done
