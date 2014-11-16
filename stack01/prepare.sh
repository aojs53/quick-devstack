#!/bin/bash

TOP_DIR=$(cd $(dirname "$0") && pwd)
DEVSTACK_DIR=$HOME/devstack

git clone -b stable/juno git://git.openstack.org/openstack-dev/devstack.git $DEVSTACK_DIR
cp local.conf $DEVSTACK_DIR/local.conf
cp 99-demo.sh $DEVSTACK_DIR/extras.d/
