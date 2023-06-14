#!/bin/bash
# https://www.instructables.com/Raspberry-Pi-Wifi-Hotspot/
# 
## install packages
apt install hostapd dnsmasq -y
apt remove iptables-persistent

systemctl stop   hostapd
systemctl stop   dnsmasq

## copy config
mv /etc/dnsmasq.conf /etc/dnsmasq.conf.orig

cd conf

cp dhcpcd.conf  /etc/dhcpcd.conf
cp dnsmasq.conf /etc/dnsmasq.conf
cp hostapd      /etc/default/hostapd
cp hostapd.conf /etc/hostapd/hostapd.conf
cp sysctl.conf  /etc/sysctl.conf

chmod 600       /etc/hostapd/hostapd.conf

## setup iptable
iptables -t nat -A POSTROUTING           -o eth0  -j MASQUERADE
iptables        -A FORWARD      -i eth0  -o wlan0 -j ACCEPT      -m state --state RELATED, ESTABLISHED 
iptables        -A FORWARD      -i wlan0 -o eth0  -j ACCEPT

netfilter-persistent save

## restart services
service   dhcpcd restart

systemctl start dnsmasq

systemctl unmask hostapd
systemctl enable hostapd
systemctl start  hostapd
