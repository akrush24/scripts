#!/bin/bash
if [[ -z $1 ]];then read -p "Enter the IP address, please: " HOST;else HOST=$1;fi
if [[ -z $2 ]];then read -p "Enter the USER name,  please: " USER;else USER=$2;fi

echo -e "\nAre You sure You want to repartition root filesystem in ${HOST}?\n\nWARNING!\n\nThis procedure may result in loss of all data in ${HOST}!\n"
read -p "Please type ${HOST} to run or anything should exit: " ANS
if [[ ${ANS} != ${HOST} ]];then echo Bay Bay;exit;fi

ssh-keygen -R ${HOST}

scp grow_root_part1.sh grow_root_part2.sh ${USER}@${HOST}:~/

ssh ${USER}@${HOST} "/bin/bash ~/grow_root_part1.sh;exit" 

sleep 20
ping ${HOST} -c 2 || sleep 10
ping ${HOST} -c 2 || sleep 10
ping ${HOST} -c 2 || sleep 10

ssh ${USER}@${HOST} "/bin/bash ~/grow_root_part2.sh;rm ~/grow_root_part1.sh ~/grow_root_part2.sh;history -c;" 
