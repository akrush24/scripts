#!/bin/bash
IP=$1

grep "^${IP}$" dac_ip && echo "IP IN DAC ADMIN" && exit

ping -c 1 ${IP} |awk '/ttl/ {print $6}'|awk -F\= '{if($2=="127"){print "\n\nMAYBE IT IS WINDOWS?...................................\n.......................................................\n\n"}}' | tee -a $IP
ping -c 1 -t 200 ${IP} && ssh -l root ${IP} "ETH=\$(ifconfig |egrep 'eth|ens'|awk '{print \$1}'|head -1|sed 's/://g')

if [ -f /etc/redhat-release ];then
 echo -e '\nPROSESS RHEL-CentOS ........\n'
 sed -i 's/255.255.255.0/255.255.254.0/' /etc/sysconfig/network-scripts/ifcfg-\${ETH} && /etc/init.d/network restart && echo OK....

elif [ -f /etc/os-release ];then
 echo -e '\n PROSESS Debina/Ubuntu ........\n'
 sed -i 's/255.255.255.0/255.255.254.0/' /etc/network/interfaces && /etc/init.d/networking restart && echo OK....;

else 
 echo -e \nWHAT OS IS IT?\n
fi" && (ping -c 5 ${IP} && echo -e "\nServer is live....................OK" || echo "Server no pinged!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
