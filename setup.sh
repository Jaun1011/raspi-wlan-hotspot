#!/bin/bash
# https://www.instructables.com/Raspberry-Pi-Wifi-Hotspot/

apt install hostapd dnsmasq bridge-utils -y

systemctl stop   hostapd
systemctl unmask hostapd
systemctl stop dnsmasq

mv /etc/dnsmasq.conf /etc/dnsmasq.conf.orig

cd conf

cp dhcpcd.conf  /etc/dhcpcd.conf
cp dnsmasq.conf /etc/dnsmasq.conf
cp hostapd.conf /etc/hostapd/hostapd.conf
cp hostapd      /etc/default/hostapd


iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
iptables -A FORWARD -i eth0  -o wlan0 -m state --state RELATED, ESTABLISHED -j ACCEPT
iptables -A FORWARD -i wlan0 -o eth0   -j ACCEPT

iptables-save > iptables.ipv4.nat



# iptables-restore < iptables.ipv4.nat

brctl addbr br0
brctl addif br0 eth0