#!/bin/bash

# This scritps mounts the pertition labeled as "BACKUP" (an attached external parition) and
# performs the backup of some files (immich library and Desktop files).

set -euo pipefail

PARTITION="/dev/disk/by-label/BACKUP"
MOUNT_POINT="/mnt/backup"

# Cleanup function
cleanup() {
	if /usr/bin/mountpoint -q "$MOUNT_POINT"; then
		echo "Unmounting $MOUNT_POINT..."
		/usr/bin/umount "$MOUNT_POINT"
	fi
}

# Check whether disk with label "BACKUP" exists
if [ ! -b "$PARTITION" ]; then
    echo "ERROR: disk with label BACKUP not found." 1>&2
    exit 1
fi
trap cleanup EXIT


# Mount disk
/usr/bin/mkdir -p "$MOUNT_POINT"

if ! /usr/bin/mountpoint -q "$MOUNT_POINT"; then
    /usr/bin/mount "$PARTITION" "$MOUNT_POINT" 
fi

# Create destination directories
/usr/bin/mkdir -p "$MOUNT_POINT/immich" "$MOUNT_POINT/Personal"

/usr/bin/rsync -aHAX --delete --info=progress2 /srv/services/immich-app/library/upload/ "$MOUNT_POINT/immich/"

/usr/bin/rsync -aHAX --delete --info=progress2 /home/user/Desktop/ "$MOUNT_POINT/Personal/"
