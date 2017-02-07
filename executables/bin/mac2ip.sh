#!/bin/bash
ping -c 1 -b 255.255.255.255 >>/dev/null 2>&1
arp -n | grep ${1} | cut -d" " -f1
