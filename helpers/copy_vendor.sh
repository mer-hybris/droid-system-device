#!/bin/bash

#
# Before running this script please extract raw vendor image
# and mount loop image to some mount point. Give that mount point
# parameter for this script.
#
# 1. "simg2img vendor.img vendor.raw" (Run inside Mer SDK target)
# 2. "mkdir ~/vendor"
# 3. "sudo mount -t ext4 -o loop vendor.raw ~/vendor"
# 4. "droid-system-device/helpers/copy_vendor.sh ~/vendor rpm/spec-to-modify.spec"
#

if [ $# -lt 2 ]; then
  echo "Usage: droid-system-device/helpers/$(basename $0) ~/path/to/vendor rpm/spec-to-modify.spec"
  exit
fi

VENDOR_SPARSE="sparse/vendor"
VENDOR_MOUNT=$1
MODIFY_SPEC=$(readlink -f $2)
POST_RULES=$(mktemp)
POST_SECTION_CREATED=0

# Add read permission for some binaries under vendor mount
if [ -f helpers/fixup-permissions.sh ]; then
    source helpers/fixup-permissions.sh
else
    source droid-system-device/helpers/fixup-permissions.sh
fi

# Remove current sparse and create it again
rm -rf $VENDOR_SPARSE
mkdir -p $VENDOR_SPARSE

# Copy content
echo "Copy $VENDOR_MOUNT/* to $VENDOR_SPARSE"
rsync -a --exclude="lost+found" "$VENDOR_MOUNT"/* "$VENDOR_SPARSE"

pushd $VENDOR_MOUNT 1>/dev/null
find . \( -uid +0 -or -gid +0 \) -and \( -type f -or -type d -or -type s \) -printf "[ -e /vendor/%P ] && chown %U:%G /vendor/%P\n" 2>/dev/null | LC_COLLATE="C" sort > $POST_RULES
popd 1>/dev/null

sed -i '/# rest of this file is autogenerated. do not edit/,$d' $MODIFY_SPEC
echo "# rest of this file is autogenerated. do not edit" >> $MODIFY_SPEC

if [ $(cat $POST_RULES | wc -l) -gt 0 ]; then
  echo "Updating $MODIFY_SPEC"
  echo "%post" >> $MODIFY_SPEC
  cat $POST_RULES >> $MODIFY_SPEC
  POST_SECTION_CREATED=1
fi
rm -f $POST_RULES

if [ $POST_SECTION_CREATED -eq 0 ]; then
  echo "%post" >> $MODIFY_SPEC
fi
pushd $VENDOR_MOUNT 1>/dev/null
find . -exec getcap {} + 2>/dev/null | awk '{ print "[ -e /vendor/"$1" ] && " "setcap", $3, "/vendor/"$1 }' | LC_COLLATE="C" sort >> $MODIFY_SPEC
popd 1>/dev/null

# Remove generic unused directories and files
if [ -f helpers/remove-unused.sh ]; then
    source helpers/remove-unused.sh
else
    source droid-system-device/helpers/remove-unused.sh
fi

# General patches
echo "Apply general patches:"
source droid-system-device/helpers/general-patches.sh

# Move build.prop to proper place if spec file has multiple_rpms definition
if grep -q "%define multiple_rpms 1" "$MODIFY_SPEC"; then
    if [ -f $VENDOR_SPARSE/build.prop ]; then
        DEVICE=$(grep ro.vendor.product.name $VENDOR_SPARSE/build.prop | cut -d '_' -f2)
        if [ -z $DEVICE ]; then
            DEVICE=$(grep ro.product.vendor.name $VENDOR_SPARSE/build.prop | cut -d '_' -f2)
        fi
        mkdir -p $DEVICE/vendor
        mv $VENDOR_SPARSE/build.prop $DEVICE/vendor
    fi
fi

# Move Vendor Interface Object manifest to proper place
if [ -f $VENDOR_SPARSE/etc/vintf/manifest.xml ]; then
    mkdir -p $DEVICE/vendor/etc/vintf
    mv $VENDOR_SPARSE/etc/vintf/manifest.xml $DEVICE/vendor/etc/vintf/manifest.xml
fi

# Apply patches if exist
if [ -d patches ]; then
    echo "Apply patches:"
    find patches/* | xargs patch -p1 -i
fi
