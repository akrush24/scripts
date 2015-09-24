#!/bin/bash
if [[ -z $1 ]];then read -p "Enter the IP address, please: " HOST;else HOST=$1;fi
if [[ -z $2 ]];then read -p "Enter the USER name,  please: " HOST;else USER=$2;fi

scp grow_root_part1.sh grow_root_part2.sh ${USER}@${HOST}:~/

ssh ${USER}@${HOST} "/bin/bash ~/grow_root_part1.sh;exit" 

sleep 20
ping ${HOST} -c 3 || sleep 10
ping ${HOST} -c 3 || sleep 10
ping ${HOST} -c 3 || sleep 10
#while [[ `ping ${HOST} -c 10` ]];do break;done

ssh ${USER}@${HOST} "/bin/bash ~/grow_root_part2.sh;rm ~/grow_root_part1.sh ~/grow_root_part2.sh;history -c;" 
