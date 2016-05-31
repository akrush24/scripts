#!/bin/bash
if [[ -z $1 ]];then read -p "Enter the IP address, please: " HOST;else HOST=$1;fi
#if [[ -z $2 ]];then read -p "Enter the USER name,  please: " USER;else USER=$2;fi
if [[ -z $2 ]];then USER=root;else USER=$2;fi

echo -e "\nAre You sure You want to repartition root filesystem in ${HOST}?\n\nWARNING!\n\nThis procedure may result in loss of all data in ${HOST}!\n"
read -p "Please type ${HOST} to run or anything should exit: " ANS
if [[ ${ANS} != ${HOST} ]];then echo Bay Bay;exit;fi

ssh-keygen -R ${HOST}

scp grow-root-partI.sh grow-root-partII.sh ${USER}@${HOST}:~/ || (ssh ${USER}@${HOST} \
"which scp || (ls -l /etc/redhat-release && yum install -y openssh-clients);" && \
scp grow-root-partI.sh grow-root-partII.sh ${USER}@${HOST}:~/)

ssh ${USER}@${HOST} "/bin/bash ~/grow-root-partI.sh;/bin/rm ~/grow-root-partI.sh;exit" && echo "\n\n PART I .... OK!"

sleep 60

ping ${HOST} -c 2 &>/dev/null || sleep 10
ping ${HOST} -c 2 &>/dev/null || sleep 20
ping ${HOST} -c 2 &>/dev/null || sleep 30
ping ${HOST} -c 2 &>/dev/null || sleep 40

ssh ${USER}@${HOST} "/bin/bash ~/grow-root-partII.sh && rm ~/grow-root-partII.sh && reboot" && echo "\n\n PART II .... OK!" || (sleep 60; ssh ${USER}@${HOST} "/bin/bash ~/grow-root-partII.sh && rm ~/grow-root-partII.sh && reboot" && echo -e "\n\n PART II .... OK!" || echo -e '\n\n ERROR!!! Server not rensponsibel')

sleep 10
ping ${HOST} -c 2 &>/dev/null || sleep 10
ping ${HOST} -c 2 &>/dev/null || sleep 20
ping ${HOST} -c 2 &>/dev/null || sleep 30
ping ${HOST} -c 2 &>/dev/null || sleep 40
ping ${HOST} -c 2 &>/dev/null || sleep 50

ping ${HOST} -c 2 || echo -e '\n\n ERROR!!! The Server has DIED! =('
