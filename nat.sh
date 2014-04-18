#!/bin/bash
sudo iptables -t nat -A POSTROUTING -o ppp0 -j MASQUERADE
sudo iptables -A FORWARD -i ppp0 -o etn0 -m state --state RELATED,ESTABLISHED -j ACCEPT
sudo iptables -A FORWARD -i etn0 -o ppp0 -j ACCEPT
