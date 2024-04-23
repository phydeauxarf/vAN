#!/usr/bin/env bash
ip l2tp add tunnel tunnel_id 2000 peer_tunnel_id 1000 \
              encap udp local 10.10.1.20 remote 10.10.1.10 \
              udp_sport 5000 udp_dport 6000
ip l2tp add session tunnel_id 2000 session_id 4000 \
              peer_session_id 3000

ip l2tp show tunnel 

brctl addbr br0
brctl addiff br0 eth0
brctl addif br0 eth1
ip link set dev br0 up
