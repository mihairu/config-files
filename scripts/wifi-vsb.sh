#!/bin/bash

IF=wlan0
IWCONFIG=iwconfig
IFCONFIG=ifconfig
CONFIG=~/wpa-vsb/wpa.conf
DRIVER=wext

sudo $IFCONFIG $IF down
sudo $IWCONFIG $IF essid "tuonet-eap"
sudo $IWCONFIG $IF enc off
sudo $IFCONFIG $IF up

sudo wpa_supplicant -w -i $IF -c $CONFIG -D $DRIVER &

#sudo dhcpcd eth1 &
