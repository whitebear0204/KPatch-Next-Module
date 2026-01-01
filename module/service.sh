#!/bin/sh

MODDIR=${0%/*}
PATH="$MODDIR/bin:$PATH"
CONFIG="/data/adb/kp-next/package_config"
key="$(cat /data/adb/kp-next/key | base64 -d)"

if [ -z "$key" ] || [ -z "$(kpatch $key hello)" ]; then
    exit 0
fi

[ -f "$CONFIG" ] || exit 0

until [ "$(getprop sys.boot_completed)" = "1" ]; do
    sleep 1
done

tail -n +2 "$CONFIG" | while IFS=, read -r pkg exclude allow uid; do
    if [ "$exclude" = "1" ]; then
        uid=$(grep "^$pkg " /data/system/packages.list | cut -d' ' -f2)
        [ -n "$uid" ] && kpatch "$key" exclude_set "$uid" 1
    fi
done
