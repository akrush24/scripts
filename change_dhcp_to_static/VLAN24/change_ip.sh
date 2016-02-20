#!/bin/bash
IP=$1
ping -c 2 -t 200 ${IP} && ssh -l root ${IP} "ETH=\$(ifconfig |egrep 'eth|ens'|awk '{print \$1}'|head -1|sed 's/://g')
 egrep \"release [76]\" /etc/redhat-release &&\
 grep 'BOOTPROTO' /etc/sysconfig/network-scripts/ifcfg-\${ETH}|grep dhcp && echo -e '\n' &&\
 sed -i 's/BOOTPROTO=.*/BOOTPROTO=none/' /etc/sysconfig/network-scripts/ifcfg-\${ETH} &&\
 echo -e \"IPADDR=${IP}\nNETMASK=255.255.255.0\nGATEWAY=192.168.24.1\n\" >> /etc/sysconfig/network-scripts/ifcfg-\${ETH} && echo -e '.............\n' && cat /etc/sysconfig/network-scripts/ifcfg-\${ETH} && echo -e '\n' &&\
 echo -e 'PROSESS........\n' && ps -ef|grep dhcp && echo -e '..........\n' && /etc/init.d/network restart && echo -e '\n' && ps -ef|grep dhc[p];\
 egrep \"release [5]\" /etc/redhat-release &&\
 grep 'BOOTPROTO' /etc/sysconfig/network-scripts/ifcfg-\${ETH}|grep dhcp && echo -e '\n' &&\
 sed -i 's/BOOTPROTO=.*/BOOTPROTO=static/' /etc/sysconfig/network-scripts/ifcfg-\${ETH} &&\
 echo -e \"IPADDR=${IP}\nNETMASK=255.255.255.0\nGATEWAY=192.168.24.1\n\" >> /etc/sysconfig/network-scripts/ifcfg-\${ETH} && echo -e '.............\n' && cat /etc/sysconfig/network-scripts/ifcfg-\${ETH} && echo -e '\n' &&\
 echo -e '\n' && ps -ef|grep dhc[p] && echo -e '\n' && /etc/init.d/network restart && echo -e '\n' && ps -ef|grep dhc[p] " 
ping -c 2 ${IP} && echo "....................OK" || echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
