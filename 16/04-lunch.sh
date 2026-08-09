#!/bin/bash

device=$1
buildtype=$2
buildformat=$3

target=$(tail -n 1 vendor/lineage/vars/aosp_target_release | cut -d "=" -f 2)

if [ "$buildtype" != "eng" ]; then
    export EVO_BUILD_TYPE=Official
else
    export EVO_BUILD_TYPE=Unofficial
fi

export CCACHE_MAXSIZE=300G

export CFLAGS="$CFLAGS -isystem /usr/include/x86_64-linux-gnu"
export CXXFLAGS="$CXXFLAGS -isystem /usr/include/x86_64-linux-gnu"
export KERNEL_CFLAGS="$KERNEL_CFLAGS -isystem /usr/include/x86_64-linux-gnu"
export KCFLAGS="$KCFLAGS -isystem /usr/include/x86_64-linux-gnu"

started_at=$(date -u +"%Y%m%d")
json_data="{\"codename\":\"$device\",\"started_at\":\"$started_at\"}"

if [ -f "~/$device.json" ]; then
    # Compare exsting started_at with new started_at
    existing_started_at=$(jq -r '.started_at' ~/$device.json)
    new_date=$(( existing_started_at > started_at ? existing_started_at : started_at ))
    jq -r ".started_at=$new_date" ~/$device.json
else
    echo "$json_data" > ~/$device.json
fi

source build/envsetup.sh &&
lunch lineage_$device-$target-$buildtype

if [[ "$buildformat" == "Installclean" ]]; then
    m installclean
fi
