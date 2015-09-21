#!/bin/sh

SD_DEV="$1"

if [ -n "${SD_DEV}" -a -b "${SD_DEV}" ]
then
    fdisk -l "${SD_DEV}"
    
    mounted=$(mount | grep "${SD_DEV}")
    if [ ${mounted} ]
    then
        echo "WARNING: ${SD_DEV} is mounted."
        echo "${mounted}"
    fi

    echo
    echo -n "Test ${SD_DEV} ? (y/N) "
    read resp
    
    case ${resp} in
        y|Y)
            mkfs.ext2 "${SD_DEV}"
            e2fsck -v -f -c -c "${SD_DEV}"
            ;;
    esac
else
    echo "USAGE: $0 DEVICE"
fi

