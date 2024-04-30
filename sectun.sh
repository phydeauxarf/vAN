#!/bin/bash

# Check if script is run as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

# Variables
LEFT="your_left_ip"
RIGHT="peer_right_ip"
LEFT_SUBNET="your_subnet"
RIGHT_SUBNET="peer_subnet"
PSK="your_pre_shared_key"

# Install Openswan if not installed
#if ! [ -x "$(command -v ipsec)" ]; then
#  apt-get update
#  apt-get install -y openswan
#fi

# IPsec Configuration
cat <<EOF > /etc/ipsec.conf
version 2
config setup
        nat_traversal=yes
        virtual_private=%v4:10.0.0.0/8,%v4:192.168.0.0/16,%v4:172.16.0.0/12,%v4:25.0.0.0/8,%v6:fd00::/8,%v6:fe80::/10
        protostack=netkey
        interfaces=%defaultroute

conn tunnel
        authby=secret
        auto=start
        ike=aes256-sha1;modp1024
        phase2=esp
        phase2alg=aes256-sha1;modp1024
        keyexchange=ike
        type=tunnel
        left=$LEFT
        leftsubnet=$LEFT_SUBNET
        right=$RIGHT
        rightsubnet=$RIGHT_SUBNET
EOF

# IPsec Secrets
echo "$LEFT $RIGHT : PSK \"$PSK\"" > /etc/ipsec.secrets

# Restart IPsec service
service ipsec restart

# Enable IP forwarding
echo "1" > /proc/sys/net/ipv4/ip_forward
