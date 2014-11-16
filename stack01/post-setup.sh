#!/bin/bash

source $HOME/devstack/openrc admin admin

function get_uuid () { cat - | grep " id " | awk '{print $4}'; }

nova flavor-create --ephemeral 10 standard.xsmall 100 1024 10 1
nova flavor-create --ephemeral 10 standard.small 101 2048 10 2
nova flavor-create --ephemeral 50 standard.medium 102 4096 50 2

keystone tenant-create --name SNSApp
SNSAPP_TENANT_ID=`keystone tenant-get SNSApp | get_uuid`

keystone user-create --name snsapp-infra-user --tenant SNSApp --pass passw0rd
keystone user-create --name snsapp-infra-admin --tenant SNSApp --pass passw0rd
keystone user-role-add --user snsapp-infra-admin --tenant SNSApp --role admin
keystone user-role-add --user snsapp-infra-user --tenant SNSApp --role Member

nova quota-update --instances 20 --cores 40 --ram 102400 $SNSAPP_TENANT_ID

sudo ip addr del 172.24.4.1/24 dev br-ex
neutron router-gateway-clear router1
neutron net-delete Ext-Net

neutron net-create Ext-Net --router:external=True
neutron subnet-create --name Ext-Subnet --allocation-pool start=192.168.202.129,end=192.168.202.254 --gateway 192.168.202.1 Ext-Net 192.168.202.0/24
neutron router-gateway-set router1 Ext-Net

sudo ovs-vsctl add-port br-ex eth2
# sudo ip link set dev eth2 up

# glance image-create --name centos-base --disk-format qcow2 --container-format bare --is-public False --copy-from http://192.168.200.1/centos6-base.qcow2

nova aggregate-create ag1 az1
id=$(nova aggregate-list | grep " ag1 " | cut -d"|" -f2)
nova aggregate-add-host $id stack02

nova aggregate-create ag2 az2
id=$(nova aggregate-list | grep " ag2 " | cut -d"|" -f2)
nova aggregate-add-host $id stack03

env | grep ^OS_ > $HOME/openrc-keystone-admin
