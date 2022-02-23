#!/bin/bash

ip=$(ip a | head -n 2 | tail -n 1 | cut -d"/" -f1 | cut -d' ' -f6)
echo "IP Address = $ip"

subnet=$(ip a | grep "inet " | head -n 2 | tail -n 1 | cut -d"/" -f2 | cut -d' ' -f1)
if test $subnet = 24; then
    echo "Subnet Mask : 255.255.255.0"
else
    echo "Cannot find subnet mask ip"
fi

default=$(ip route show | head -n 1 | cut -d" " -f3)
echo "Default Gateway : $default"

dhcp=$(cat /var/lib/dhcp/dhclient.leases | grep "dhcp-server" | tail -n1 | cut -d"-" -f3 | cut -d" " -f2 | cut -d ";" -f1)
echo "DHCP Server IP : $dhcp"

dns=$(systemd-resolve --status | grep "DNS " | head -n 2 | tail -n 1 | cut -d":" -f2)
echo "DNS Server : $dns"
exit 0