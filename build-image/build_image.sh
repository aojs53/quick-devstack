#!/bin/bash -e

format=raw
vmname=cent6_build$$
buildfile=/tmp/centos6-$$.img

rm -f $buildfile
qemu-img create -f $format $buildfile 10G
virt-install --virt-type kvm --name $vmname \
  --ram 2048 --os-type=linux --os-variant=rhel6 \
  --nographics \
  --disk $buildfile,format=$format \
  --network network=openstack,model=virtio \
  --location=http://ftp.riken.jp/Linux/centos/6/os/x86_64/ \
  --initrd-inject centos6-ks.cfg \
  --extra-args="ks=file:/centos6-ks.cfg console=tty0 console=ttyS0,115200n8 serial"
virsh destroy $vmname
virsh undefine $vmname
virt-sysprep -a $buildfile
qemu-img convert -c -O qcow2 $buildfile /var/www/html/centos6-base.qcow2
rm -f $buildfile

echo ""
echo "Done. CentOS6 image was created at /var/www/html/centos6-base.qcow2"
