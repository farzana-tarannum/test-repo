#!/bin/sh
#
# QEMU wrapper script
# This script is a wrapper for QEMU, which is used to run the
# virtual machine. It sets up the environment and calls QEMU
# with the correct parameters.
qemu-img create -f qcow2 k2.qcow2 20G
qemu-system-x86_64 -enable-kvm -m 2048 -cpu host -smp 2 -drive\
	file=k2.qcow2,if=virtio -cdrom /home/centos7.iso -boot d -vnc\
	:1 -vga cirrus -monitor stdio -net tap,ifname=tap0,script=no,\
	downscript=no -net nic,model=virtio -name centos7 -daemonize
qemu-img create -f qcow1 /var/lib/libvirt/images/centos7.qcow2

qemu-system-x86_64 -enable-kvm -m 2048 -cpu host -smp 2 -drive\
	file=/var/lib/libvirt/images/centos7.qcow2,if=virtio -cdrom\
	/home/centos7.iso -boot d -vnc :1 -vga cirrus -monitor stdio\
	-net tap,ifname=tap0,script=no,downscript=no -net\
	nic,model=virtio -name centos7 -daemonize
qemu-system-x86_64 -enable-kvm -m 2048 -cpu host -smp 2 -drive\
	file=/var/lib/libvirt/images/centos7.qcow2,if=virtio -cdrom\
	/home/centos7.iso -boot d -vnc :1 -vga virtio -display sdl,gl=on  -monitor stdio\
	-net tap,ifname=tap0,script=no,downscript=no -net\
	nic,model=virtio -name centos7 -daemonize

# explaination if=virtio
# The if=virtio option specifies that the disk should be connected
# to the virtual machine using the virtio driver. This is a paravirtual
# driver that is optimized for use in virtual machines and provides
# better performance that the default IDE or SCSI drivers.

# explaination -vnc :1
# The -vnc :1 option specifies that the virtual machine should be
# accessible via VNC on port 5901. This allows you to connect to the
# virtual machine using a VNC client and interact with it as if it
# were a physical machine.
# The -vga cirrus option specifies that the virtual machine should
# use the Cirrus Logic GD5446 video card, which is a simple and
# well-supported video card that is compatible with most operating
# systems.
# The -monitor stdio option specifies that the QEMU monitor should
# be accessible via the standard input and output. This allows you to
# interact with the virtual machine using the QEMU monitor commands,
# which can be useful for debugging and troubleshooting.
#
# The -net tap,ifname=tap0,script=no,downscript=no option specifies
# that the virtual machine should be connected to the network using
# a TAP devices named tap0 and that no script should be run when the
# device is brought up or down. This allows you to connect the virtual
# machine to the host network using a TAP device, which can be useful
# for testing and development.
#
# The -net nic,model=virtio option specifies that the virtual machine
# should use the virtio network driver, which is a paravirtual driver
# that is optimized for use in virtual machines and provides better
# performance than the default e1000 or rtl8139 drivers.
# The -name centos7 option specifies that the virtual machine should
# be named centos7. This can be useful for identifying the virtual
# machine in the QEMU monitor and other management tools.
#
# The -daemonize option specifies that QEMU should run in the background
# as a daemon. This allows you to start the virtual machine and then
# disconnect from it, while it continues to run in the background.
# You can use the virsh command to manage the virtual machine, such as
# starting, stopping, and viewing its status.
# The virsh command is a command-line tool for managing virtual machines
# using the libvirt API. It provides a wide range of functionality for
# managing virtual machines, including starting, stopping, pausing,
# resuming, and migrating virtual machines, as well as viewing their
# status, configuration, and performance statistics.
#
# The virsh command can be used to manage virtual machines on the local
# host, as well as on remote hosts using the libvirt API. It can also be
# used to manage virtual networks, storage pools, and other resources
# using the libvirt API. The virsh command provides a powerful and
# flexible interface for managing virtual machines and other resources
# using the libvirt API, and is widely used in the industry for managing
# virtualization environments.
#
# status of the virtual machine
# virsh list --all
#
# start the virtual machine
# virsh start centos7
#
# stop the virtual machine
# virsh shutdown centos7
#
# view the status of the virtual machine
# virsh dominfo centos7
# virsh domstate centos7
# apt-get install qemu-kvm libvirt-bin virtinst
# debian cloud image in qcow2 format
# wget https://cloud.debian.org/images/cloud/buster/20220110-732/debian-11-generic-amd64-20220110-732.qcow2
# qemu-img create -f qcow2 debian.qcow2 20G
# qemu-system-x86_64 -enable-kvm -m 2048 -cpu host -smp 2 -drive\
# file=debian.qcow2,if=virtio -cdrom /home/debian-11-generic-amd64-20220110-732.qcow2 -boot d -vnc\
# :1 -vga cirrus -monitor stdio -net tap,ifname=tap0,script=no,\
# downscript=no -net nic,model=virtio -name debian -daemonize
# virsh list --all
# virsh start debian
# create a new tap device
# ip tuntap add dev tap1 mode tap
# ip link set tap1 up

