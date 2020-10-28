#!/bin/bash
#
# On Mediatek devices /dev/net permissions have been restricted for root only,
# allow access also for others and group.
# e.g. VPN clients needs access to /dev/net/tun with special user group.

patch_file="init.wod.rc"
echo "Finding $patch_file"
patch_file_path=$(find "$SYSTEM_SPARSE" -type f -name $patch_file)
if [ ! -z "$patch_file_path" ]; then
  echo "Patching file $patch_file_path"
  sed -i -e 's!mkdir /dev/net/ 0700 root root!mkdir /dev/net/ 0755 root root!g' "$patch_file_path"
else
  echo "File $patch_file does not exist, skipping..."
fi
