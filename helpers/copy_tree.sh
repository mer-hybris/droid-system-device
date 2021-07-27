#!/bin/bash

#
# Before running this script please extract raw images and mount them.
# Pass them as parameters to this script.
#
# 1. "simg2img system.img system.raw"
# 2. "simg2img vendor.img vendor.raw"
# 3. "mkdir ~/system ~/vendor"
# 4. "sudo mount -t ext4 -o loop system.raw ~/system"
# 5. "sudo mount -t ext4 -o loop vendor.raw ~/vendor"
# 6. "droid-system-device/helpers/copy_tree.sh ~/system ~/vendor rpm/spec-to-modify.spec"
#

if [ $# -lt 2 ]; then
  echo "Usage: droid-system-device/helpers/$(basename "$0") path/to/tree1 ... rpm/spec-to-modify.spec"
  exit
fi

get_closest() {
    if [ -f "$1" ]; then
        echo "$1"
    elif [ -f droid-system-device/"$1" ]; then
        echo droid-system-device/"$1"
    else
        echo /dev/null
    fi
}

SPARSE=sparse

arg=""
trees=()
for var in "$@"; do
    if [ -n "$arg" ]; then
        trees+=("$arg")
    fi
    arg=$var
done

modify_spec=$(readlink -f "$arg")
post_rules=$(mktemp)

token="# rest of this file is autogenerated. do not edit"
sed -i "/$token/,\$d" "$modify_spec"
echo "$token" >> "$modify_spec"
echo "%post" >> "$modify_spec"

for tree_mount in "${trees[@]}"; do

TREE=$(basename "$tree_mount")
TREE_MOUNT=$tree_mount
TREE_SPARSE=$SPARSE/$TREE

# Add read permission for some binaries under mount
source "$(get_closest helpers/fixup-permissions-"$TREE".sh)"

# Remove current sparse and create it again
rm -rf "$TREE_SPARSE"
mkdir -p "$TREE_SPARSE"

# Copy content
echo "Copy $TREE_MOUNT/* to $TREE_SPARSE"
rsync -a --exclude="lost+found" "$TREE_MOUNT"/* "$TREE_SPARSE"

pushd "$TREE_MOUNT" 1>/dev/null || exit
find . \( -uid +0 -or -gid +0 \) -and \( -type f -or -type d -or -type s \) -printf "[ -e /$TREE/%P ] && chown %U:%G /$TREE/%P ||:\n" 2>/dev/null | LC_ALL="C" sort > "$post_rules"
popd 1>/dev/null || exit

if [ "$(wc -l < "$post_rules")" -gt 0 ]; then
  echo "Updating $modify_spec"
  cat "$post_rules" >> "$modify_spec"
fi
rm -f "$post_rules"

pushd "$TREE_MOUNT" 1>/dev/null || exit
find . -exec getcap {} + 2>/dev/null | awk -v tree="$TREE" '{ print "[ -e /"tree"/"$1" ] && " "setcap", $3, "/"tree"/"$1 }' | LC_COLLATE="C" sort >> "$modify_spec"
popd 1>/dev/null || exit

# Remove generic unused directories and files
source "$(get_closest helpers/remove-unused-"$TREE".sh)"

# General patches
echo "Apply general patches:"
source droid-system-device/helpers/general-patches.sh

# Strip username present at buildtime
sed -e "s/$(id -u -n )/abuild/g" -i "$TREE_SPARSE"/build.prop

# Strip hostname present at buildtime
sed -e "s/$(hostname)/abuilder/g" -i "$TREE_SPARSE"/build.prop

# Move build.prop to proper place if spec file has multiple_rpms definition
if grep -q "%define multiple_rpms 1" "$modify_spec"; then
    if [ "$TREE" = "system" ]; then
        if [ -f "$TREE_SPARSE"/build.prop ]; then
            DEVICE=$(grep ro.product.name "$TREE_SPARSE"/build.prop | cut -d '_' -f2)
            if [ -z "$DEVICE" ]; then
                DEVICE=$(grep ro.product.system.name "$TREE_SPARSE"/build.prop | cut -d '_' -f2)
            fi
            if [ -z "$DEVICE" ]; then
                echo "Could not parse device name from $TREE_SPARSE/build.prop"
                exit 1
            fi
            mkdir -p "$DEVICE"/system
            mv "$TREE_SPARSE"/build.prop "$DEVICE"/system
            if [ -f "$TREE_SPARSE"/etc/prop.default ]; then
                mkdir -p "$DEVICE"/system/etc
                mv "$TREE_SPARSE"/etc/prop.default "$DEVICE"/system/etc/prop.default
            fi
        fi
    elif [ "$TREE" = "vendor" ]; then
        if [ -f "$TREE_SPARSE"/build.prop ]; then
            DEVICE=$(grep ro.vendor.product.name "$TREE_SPARSE"/build.prop | cut -d '_' -f2)
            if [ -z "$DEVICE" ]; then
                DEVICE=$(grep ro.product.vendor.name "$TREE_SPARSE"/build.prop | cut -d '_' -f2)
            fi
            if [ -z "$DEVICE" ]; then
                echo "Could not parse device name from $TREE_SPARSE/build.prop"
                exit 1
            fi
            mkdir -p "$DEVICE"/vendor
            mv "$TREE_SPARSE"/build.prop "$DEVICE"/vendor
        fi

        # Move Vendor Interface Object manifest to proper place
        if [ -f "$TREE_SPARSE"/etc/vintf/manifest.xml ]; then
            mkdir -p "$DEVICE"/vendor/etc/vintf
            mv "$TREE_SPARSE"/etc/vintf/manifest.xml "$DEVICE"/vendor/etc/vintf/manifest.xml
        fi
    fi
fi

# Apply patches if exist
if [ -d patches-"$TREE" ]; then
    echo "Apply patches:"
    for p in patches-"$TREE"/*; do
        patch -p1 -f -i "$p"
    done
fi

done  # for tree_mount in "${trees[@]}"; do
