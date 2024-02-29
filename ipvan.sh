#!/bin/bash 

ip -br -c link show | awk '{print $1}' | grep -v lo | while read -r line ; do
#    ip link set dev $line down
#    ip link set dev $line up
	echo $line
done

ip -br -c link show 

docker run --rm -it ubuntu /bin/bash -c "ip -br -c link show"



#ip link add link enp0s3 name enp0s3.10 type vlan id 10 mode l3 


