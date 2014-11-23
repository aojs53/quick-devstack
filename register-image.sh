#!/bin/bash

TOP_DIR=$(cd $(dirname "$0") && pwd)

source $TOP_DIR/openrc-infra-user

glance image-create --name centos-base \
  --disk-format qcow2 --container-format bare \
  --is-public False \
  --copy-from http://192.168.100.1/centos6-base.qcow2
