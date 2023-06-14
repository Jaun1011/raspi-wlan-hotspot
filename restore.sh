#!/bin/bash

cp /etc/dhcpcd.conf.bkp             /etc/dhcpcd.conf
cp /etc/dnsmasq.conf.bkp            /etc/dnsmasq.conf
cp /etc/hostapd/hostapd.conf.bkp    /etc/hostapd/hostapd.conf
cp /etc/default/hostapd.bkp         /etc/default/hostapd
cp /etc/sysctl.conf.bkp             /etc/sysctl.conf

service dhcpcd restart
systemctl stop hostapd 
systemctl stop dnsmasq

