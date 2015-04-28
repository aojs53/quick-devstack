#!/bin/bash

TOP_DIR=$(cd $(dirname "$0") && pwd)
DEVSTACK_DIR=$HOME/devstack

sudo yum -y install iptables-services
sudo systemctl disable firewalld
sudo systemctl stop firewalld
sudo systemctl enable iptables
cat /dev/null > /etc/sysconfig/iptables
sudo systemctl start iptables

git clone -b stable/juno git://git.openstack.org/openstack-dev/devstack.git $DEVSTACK_DIR
cp -v $TOP_DIR/local.conf $DEVSTACK_DIR/local.conf
cp -v $TOP_DIR/99-demo.sh $DEVSTACK_DIR/extras.d/
