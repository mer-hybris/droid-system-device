#!/bin/bash

# Add read permission for some binaries under system mount

if [ "$TREE_MOUNT" == "" ]; then
    echo "TREE_MOUNT is unset!"
    exit 1
fi

fixup() {
    f=$TREE_MOUNT/$1
    [ -f "$f" ] && sudo chmod a+r "$f"
}

# Add read permission for some binaries under vendor mount
fixup build.prop
fixup default.prop
fixup bin/hw/android.hardware.bluetooth@1.0-service-qti
