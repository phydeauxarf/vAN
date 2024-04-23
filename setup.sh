#!/usr/bin/env bash
modprobe l2tp_eth
apt-get update
# bridge-util package to enable interface bridging  dnsutils to install nslookup
apt-get install bridge-utils dnsutils -y
