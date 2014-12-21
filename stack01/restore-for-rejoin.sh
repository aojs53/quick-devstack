#!/bin/bash

SWIFT_DATA_DIR=/opt/stack/data/swift
SWIFT_DISK_IMAGE=${SWIFT_DATA_DIR}/drives/images/swift.img
SWIFT_DRIVE=${SWIFT_DATA_DIR}/drives/sdb1

if [[ -e ${SWIFT_DISK_IMAGE} ]]; then
    mkdir -p ${SWIFT_DRIVE}
    if ! egrep -q ${SWIFT_DRIVE} /proc/mounts; then
        sudo mount -t xfs -o loop,noatime,nodiratime,nobarrier,logbufs=8  \
            ${SWIFT_DISK_IMAGE} ${SWIFT_DRIVE}
        echo "Mount ${SWIFT_DISK_IMAGE} to ${SWIFT_DATA_DIR}"
    fi
fi
