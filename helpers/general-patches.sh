# On Mediatek devices /dev/net permissions have been restricted for root only,
# allow access also for others and group.
# e.g. VPN clients needs access to /dev/net/tun with special user group.

PATCH_FILE="init.wod.rc"
echo "Finding $PATCH_FILE"
PATCH_FILE_PATH=$(find $SYSTEM_SPARSE -type f -name $PATCH_FILE)
if [ ! -z "$PATCH_FILE_PATH" ]; then
  echo "Patching file $PATCH_FILE_PATH"
  sed -i -e 's!mkdir /dev/net/ 0700 root root!mkdir /dev/net/ 0755 root root!g' $PATCH_FILE_PATH
else
  echo "File $PATCH_FILE does not exist, skipping..."
fi
