!/bin/bash
ip -br -c addr 
# ip -br stands for brief output -c stands for color output
ip tuntap add dev tun0 mode tun
# add dev tun0: add a new tun0 interface of mode tun 
# tun0: <POINTOPOINT,MULTICAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc 
# fq_codel state UNKNOWN group default qlen 100
# tantap is a virtual network device that can be used to create a 
# point-to-point or point-to-multipoint connection between two 
# network devices. It can be used to create a network bridge 
# to connect two network segments.
ip tuntap add dev tun1 mode tun
# echo "1" > /proc/sys/net/ipv4/ip_forward
# enable ip forwarding in the kernel 
# echo "1" > /proc/sys/net/ipv4/conf/all/forwarding
# enable ip forwarding for all network interfaces
# echo "1" > /proc/sys/net/ipv4/conf/enp0s3/forwarding
# echo "1" > /proc/sys/net/ipv4/conf/tun0/forwarding
# echo "1" > /proc/sys/net/ipv4/conf/br0/forwarding
# echo "1" > /proc/sys/net/ipv4/conf/all/proxy_arp
# echo "1" > /proc/sys/net/ipv4/conf/enp0s3/proxy_arp
# proxy_arp is a feature that allows a system to 
# respond to ARP requests on behalf of other systems.
# echo "1" > /proc/sys/net/ipv4/conf/tun0/proxy_arp
# echo "1" > /proc/sys/net/ipv4/conf/br0/proxy_arp
# description: add a new tun0 interface
# mode: tun
ip link set tun0 up
ip link add name br0 type bridge
# ip link add name adds a new network interface with the 
# specified name and type. In this case, we are adding a
# new network interface with the name br0 and type bridge.
# ip link add name veth0 type veth peer name veth1
# add a new veth0 interface with a peer veth1
# ip link add name veth0 type veth peer name veth1 netns ns1
# add a new veth0 interface with a peer veth1 in the network
# namespace ns1
# ip link add name a0 type macvlan mode bridge
# add a new macvlan interface with the name a0 and mode bridge
# ip link add name c0 type vrf table 100
# add a new vrf interface with the name c0 and table 100
# ip link add name y0 type vlan id 100
# add a new vlan interface with the name y0 and vlan id 100
# ip link add name e0 type vxlan id 100
# and a new vxlan interface with the name e0 and vxlan id 100
# ip link add name b0 type bridge vlan_filtering 1
# add a new bridge interface with the name b0 and vlan filtering 
# enabled
# ip link add name g0 type gretap remote
# add a new gretap interface with the name g0 
# and a remote endpoint specified
ip link set br0 up
# set the br0 interface up
# ip link set veth0 up
ip link set tun0 master br0
# set the tun0 interface as a member of the br0 bridge
ip link set tun1 master br0
# to connect the enp0s3 interface to the br0 bridge
# ip link set enp0s3 master br0
# show the bridge interfaces
# ip -br -c link ls 
# ip -br -c link ls br0
# ip -br -c link ls tun0
# test the bridge interface
ip link add link enp0s3 name ipnet1 type ipvlan mode l3
# ip vlan is a type of virtual network device that can be used to create
# a virtual network interface that is a member of a VLAN. It can be use to
# create a network bridge to connect two network segments.
ip netns ls 
# netns stands for network namespace in the linux kernel
# namespace is a feature that allows a process to have its
# own view of the system resources such as network interfaces
# and routing tables. It can be use to create a virtual network
# environment that is isolated from the rest of the system.
ip netns add ns1
# add a new network namespace with the name ns1
ip link set ipnet1 netns ns1
ip link name veth0 type veth peer name veth1
ip link set veth1 netns ns1
ip link set veth0 up
ip netns exec ns1 ip -br -c link ls
ip netns exce ns1 ip link set lo up
ip netns exec ns1 ip link set ipnet1 up
ip netns exec ns1 ip addr add 
ip -n ns1 -br -c link ls 
