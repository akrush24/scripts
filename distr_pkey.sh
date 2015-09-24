#!/bin/bash
if [[ -z $1 ]];then read -p "Enter the IP address, please: " HOST;else HOST=$1;fi
if [[ -z $2 ]];then read -p "Enter User Name, please: " USER;else USER=$2;fi
if [ -f ${HOME}/.ssh/id_dsa.pub ];then export PKEY=`cat ${HOME}/.ssh/id_dsa.pub`;else export PKEY=`cat ${HOME}/.ssh/id_rsa.pub`;fi
ssh-keygen -R $HOST
ssh -o "BatchMode yes" $HOST -l $USER "hostname" || ssh $HOST -l $USER "if [ -d ~${USER}/.ssh/ ];then grep \"$PKEY\" ~${USER}/.ssh/authorized_keys && echo 'KEY is EXIST'||echo $PKEY>>~${USER}/.ssh/authorized_keys;else mkdir -p ~${USER}/.ssh/;chmod 700 ~${USER}/.ssh;echo $PKEY>>~${USER}/.ssh/authorized_keys;fi;chmod 600 ~${USER}/.ssh/authorized_keys;/sbin/restorecon -R ~${USER}/.ssh/"
