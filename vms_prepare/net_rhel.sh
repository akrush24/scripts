#!/bin/bash
if [[ -z $1 ]];then read -p "Enter the IP address, please: " HOST;else HOST=$1;fi
if [[ -z $2 ]];then read -p "Enter the USER name,  please: " USER;else USER=$2;fi
if [[ -z $3 ]];then read -p "Enter new mashin name, please: " HOST_NAME;else HOST_NAME=$3;fi


ssh ${USER}@${HOST} <<EOF!
if [[ -f /etc/redhat-release ]]
then 
  if [[ \`egrep "release\ [56]" /etc/redhat-release\` ]]
  then
    echo -e "NETWORKING=yes\nHOSTNAME=${HOST_NAME}\nDHCP_HOSTNAME=\`/bin/hostname\`" > /etc/sysconfig/network 
  else
    echo -e "NETWORKING=yes\nHOSTNAME=${HOST_NAME}\nDHCP_HOSTNAME=${HOST_NAME}" > /etc/sysconfig/network
    echo ${HOST_NAME} > /etc/hostname
  fi
  hostname ${HOST_NAME}
fi
EOF!

