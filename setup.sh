#!/usr/bin/env bash
modprobe l2tp_eth
apt-get update
apt-get install bridge-utils -y
