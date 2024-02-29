#!/bin/sh
#
# Linix IPvlan setup script
#
# ip -c -br link show 
# describes the interfaces
# ip -c -br link show type ipvlan
# ip link add name br0 type bridge
# ip link set br0 up
# ip link set enp0s25 master br0 
# ip link set enp0s25 up
# ip link add link br0 name ipv0 type ipvlan mode l2
# ip link set ipv0 up
# ip link set ipv0 master br0
# ip -c -br link show
# ip -c -br link show type ipvlan
# ip -c -br link show type bridge
