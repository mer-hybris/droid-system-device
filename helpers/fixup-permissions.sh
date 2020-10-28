#!/bin/bash

# Add read permission for some binaries under system mount

if [ "$SYSTEM_MOUNT" == "" ]; then
    SYSTEM_MOUNT=$VENDOR_MOUNT
fi

if [ "$SYSTEM_MOUNT" == "" ]; then
    echo "SYSTEM_MOUNT and VENDOR_MOUNT are unset!"
    exit 1
fi

sudo chmod a+r "$SYSTEM_MOUNT"/bin/run-as
sudo chmod a+r "$SYSTEM_MOUNT"/bin/uncrypt
sudo chmod a+r "$SYSTEM_MOUNT"/bin/netcfg
sudo chmod a+r "$SYSTEM_MOUNT"/bin/install-recovery.sh
sudo chmod a+r "$SYSTEM_MOUNT"/etc/dhcpcd/dhcpcd-run-hooks
sudo chmod a+r "$SYSTEM_MOUNT"/etc/partition_permission.sh
sudo chmod a+r "$SYSTEM_MOUNT"/etc/wide-dhcpv6/dhcp6c.script
sudo chmod a+r "$SYSTEM_MOUNT"/xbin/su
sudo chmod a+r "$SYSTEM_MOUNT"/bin/logd
sudo chmod a+r "$SYSTEM_MOUNT"/bin/webview_zygote32
sudo chmod a+r "$SYSTEM_MOUNT"/bin/webview_zygote64
sudo chmod a+r "$SYSTEM_MOUNT"/build.prop
sudo chmod a+r "$SYSTEM_MOUNT"/etc/prop.default
sudo chmod a+r "$SYSTEM_MOUNT"/default.prop
sudo chmod a+r "$SYSTEM_MOUNT"/bin/hw/android.hardware*
sudo chmod a+r "$SYSTEM_MOUNT"/bin/secilc
sudo chmod a+r "$SYSTEM_MOUNT"/etc/fs_config_dirs

