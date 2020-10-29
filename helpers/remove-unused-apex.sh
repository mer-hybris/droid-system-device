#!/bin/bash
#
# Remove unused files, or files that should not be used

if [ -z "$TREE_SPARSE" ]; then
    echo "TREE_SPARSE is unset!"
    exit 1
fi

rm -rf "$TREE_SPARSE"/com.android.runtime/apex_manifest.json
rm -rf "$TREE_SPARSE"/com.android.runtime/apex_pubkey
rm -rf "$TREE_SPARSE"/com.android.runtime/javalib
