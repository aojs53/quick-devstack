#!/bin/bash

TOP_DIR=$(cd $(dirname "$0") && pwd)
DEVSTACK_DIR=$TOP_DIR/devstack

git clone -b stable/juno git://git.openstack.org/openstack-dev/devstack.git $DEVSTACK_DIR
cp local.conf $DEVSTACK_DIR/local.conf
