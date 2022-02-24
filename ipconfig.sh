#!/bin/bash

echo "*****************************************"
echo "* Linux IP-Config Command Made by AlonD *"
echo "*****************************************"

ip=$(ip a | grep "inet "| head -n 2 | tail -n 1 | cut -d"/" -f1 | cut -d' ' -f6)
echo "IP Address: $ip"

subnet=$(ip a | grep "inet " | head -n 2 | tail -n 1 | cut -d"/" -f2 | cut -d' ' -f1)
if test $subnet = 23; then
    echo "Subnet Mask: 255.255.254.0"
elif test $subnet = 24; then
    echo "Subnet Mask: 255.255.255.0"
elif test $subnet = 16; then
    echo "Subnet Mask: 255.255.0.0"
elif test $subnet = 8; then
   echo "Subnet Mask: 255.0.0.0"
else
    echo "Cannot find subnet mask ip"
fi

default=$(ip route show | head -n 1 | cut -d" " -f3)
echo "Default Gateway: $default"

#dhcp=$(cat /var/lib/dhcp/dhclient.leases | grep "dhcp-server" | tail -n1 | cut -d"-" -f3 | cut -d" " -f2 | cut -d ";" -f1)
dhcp=$(ip r | head -n 1 | cut -d" " -f3)
echo "DHCP Server IP: $dhcp"

#dns=$(systemd-resolve --status | grep "DNS " | head -n 2 | tail -n 1 | cut -d":" -f2)
dns=$(systemd-resolve --status | grep "Current" | tail -n 1 | cut -d" " -f6)
echo "DNS Server: $dns"

ipv6=$(ip a | grep "inet6 " | head -n 2 | tail -n 1 | cut -d"/" -f1 | cut -d' ' -f6)
echo "IPV6: $ipv6"

wired=$(ip a | grep "2: " | cut -d":" -f2 | cut -d" " -f2)
echo "Wired Interface: $wired"

date=$(date)
echo "Date: $date"

tz=$(timedatectl | grep "Time " | cut -d":" -f2)
echo "Time Zone:$tz"

lang=$(locale | head -n 1 | cut -d"=" -f2 | cut -d"." -f1)
echo "Language: $lang"

#PiHole Users!!!!!
pihole=$(lxc list | grep "(eth0) " | cut -d"|" -f4 | cut -d" " -f2)
if test $pihole != $pihole; then
	echo "PiHole Cannot be found"
else
	echo "PiHole IP: $pihole"
fi
exit 0