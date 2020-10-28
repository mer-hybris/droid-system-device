#!/bin/bash

# Add read permission for some binaries under system mount

if [ "$SYSTEM_MOUNT" == "" ]; then
    SYSTEM_MOUNT=$VENDOR_MOUNT
fi

if [ "$SYSTEM_MOUNT" == "" ]; then
    echo "SYSTEM_MOUNT and VENDOR_MOUNT are unset!"
    exit 1
fi

fixup() {
    f=$SYSTEM_MOUNT/$1
    [ -f "$f" ] && sudo chmod a+r "$f"
}

fixup bin/run-as
fixup bin/uncrypt
fixup bin/netcfg
fixup bin/install-recovery.sh
fixup etc/dhcpcd/dhcpcd-run-hooks
fixup etc/partition_permission.sh
fixup etc/wide-dhcpv6/dhcp6c.script
fixup xbin/su
fixup bin/logd
fixup bin/webview_zygote32
fixup bin/webview_zygote64
fixup build.prop
fixup etc/prop.default
fixup default.prop
fixup bin/hw/android.hardware*
fixup bin/secilc
fixup etc/fs_config_dirs
