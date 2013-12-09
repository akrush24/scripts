#!/bin/bash
if [ ! -z $1 ]
then
ssh -o"PasswordAuthentication no" $1 "esxcli system syslog config set --loghost='tcp://192.168.24.89:514';\
	esxcli system syslog reload;\
	esxcli network firewall ruleset set --ruleset-id=syslog --enabled=true;\
	esxcli network firewall refresh"
else
echo "$0 \${HOSTNAME}"
fi
