#!/bin/bash
IP=$1
touch $IP

echo "----------------------------------------------------------------"
echo "--------------------------- $IP "
echo "----------------------------------------------------------------"


grep "^${IP}$" dac_ip && echo "IP IN DAC ADMIN" && exit

ping -c 1 ${IP} |awk '/ttl/ {print $6}'|awk -F\= '{if($2=="127"){print "\n\nMAYBE IT IS WINDOWS?...................................\n.......................................................\n\n"}}' | tee -a $IP
ping -c 1 -t 200 ${IP} && ssh -l root ${IP} "ETH=\$(ifconfig |egrep 'eth|ens'|awk '{print \$1}'|head -1|sed 's/://g')

if [ -f /etc/redhat-release ];then
    echo -e '\nPROSESS RHEL-CentOS ........\n'

    if [ \"\$(egrep \"release [76]\" /etc/redhat-release)\" ];then

     echo -e '  PROSESS RHEL 6-7 ........\n'
     grep 'BOOTPROTO' /etc/sysconfig/network-scripts/ifcfg-\${ETH}|grep dhcp && echo -e '\n' &&\
     sed -i 's/BOOTPROTO=.*/BOOTPROTO=none/' /etc/sysconfig/network-scripts/ifcfg-\${ETH} &&\
     sed -i 's/DOMAIN.*//g' /etc/sysconfig/network-scripts/ifcfg-\${ETH} &&\
     echo -e \"IPADDR=${IP}\nNETMASK=255.255.255.0\nGATEWAY=192.168.32.1\n\" >> /etc/sysconfig/network-scripts/ifcfg-\${ETH} && echo -e '.............\n' &&\
     cat /etc/sysconfig/network-scripts/ifcfg-\${ETH} && echo -e '\n' && ps -ef|grep dhc[p] &&\
     echo -e '\n' && /etc/init.d/network restart && echo -e '\n' && ps -ef|grep dhc[p]

    elif [ \"\$(egrep \"release [5]\" /etc/redhat-release)\" ];then

     echo -e '  PROSESS RHEL 4-5 ........\n'
     grep 'BOOTPROTO' /etc/sysconfig/network-scripts/ifcfg-\${ETH}|grep dhcp && echo -e '\n' &&\
     sed -i 's/BOOTPROTO=.*/BOOTPROTO=static/' /etc/sysconfig/network-scripts/ifcfg-\${ETH} &&\
     sed -i 's/DOMAIN.*//g' /etc/sysconfig/network-scripts/ifcfg-\${ETH} &&\
     echo -e \"IPADDR=${IP}\nNETMASK=255.255.255.0\nGATEWAY=192.168.32.1\n\" >> /etc/sysconfig/network-scripts/ifcfg-\${ETH} && echo -e '.............\n' &&\
     cat /etc/sysconfig/network-scripts/ifcfg-\${ETH} && echo -e '\n' && ps -ef|grep dhc[p] &&\
     echo -e '\n' && /etc/init.d/network restart && echo -e '\n' && ps -ef|grep dhc[p]

    fi;

elif [ -f /etc/os-release ];then

 echo -e '\n PROSESS Debina/Ubuntu ........\n'
 cat /etc/network/interfaces
 if [ \"\$(egrep 'iface.*eth0.*dhcp' /etc/network/interfaces)\" ];then
  sed -i 's/dhcp/static/' /etc/network/interfaces &&\
  echo -e 'address ${IP}\nnetmask 255.255.255.0\ngateway 192.168.32.1\ndns-nameservers 192.168.32.10' >> /etc/network/interfaces &&\
  /etc/init.d/networking restart;
  killall dhclient
  cat /etc/network/interfaces
 else
  echo -e '\t\n'NO DHCP ON \${ETH}'\n'
 fi

else 
 echo -e \nWHAT OS IS IT?\n
fi" && (ping -c 3 ${IP} && echo -e "\nServer is live....................OK" || echo "Server no pinged!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
