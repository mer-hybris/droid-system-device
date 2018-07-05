# Add read permission for some binaries under system mount
sudo chmod a+r $SYSTEM_MOUNT/bin/run-as
sudo chmod a+r $SYSTEM_MOUNT/bin/uncrypt
sudo chmod a+r $SYSTEM_MOUNT/bin/netcfg
sudo chmod a+r $SYSTEM_MOUNT/bin/install-recovery.sh
sudo chmod a+r $SYSTEM_MOUNT/etc/dhcpcd/dhcpcd-run-hooks
sudo chmod a+r $SYSTEM_MOUNT/etc/partition_permission.sh
sudo chmod a+r $SYSTEM_MOUNT/etc/wide-dhcpv6/dhcp6c.script
sudo chmod a+r $SYSTEM_MOUNT/xbin/su
sudo chmod a+r $SYSTEM_MOUNT/bin/logd
sudo chmod a+r $SYSTEM_MOUNT/bin/webview_zygote32
sudo chmod a+r $SYSTEM_MOUNT/bin/webview_zygote64
sudo chmod a+r $SYSTEM_MOUNT/build.prop
sudo chmod a+r $SYSTEM_MOUNT/etc/prop.default

