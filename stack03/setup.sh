#!/bin/bash

TOP_DIR=$(cd $(dirname "$0") && pwd)
DEVSTACK_DIR=$HOME/devstack

sudo pvcreate /dev/vdb
sudo vgcreate cinder-volumes /dev/vdb
sudo pvs
sudo vgs

git clone -b stable/juno git://git.openstack.org/openstack-dev/devstack.git $DEVSTACK_DIR
cp local.conf $DEVSTACK_DIR/local.conf
