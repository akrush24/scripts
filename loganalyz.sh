#!/bin/bash

# Parameters
if [[ -z $1 ]];then echo "HOST is empty...";exit 1;else HOST=$1;fi
LOGNAME=vmkernel-`date +%Y-%m-%d`
LOGDIR=/zpool/${HOST}/`date +%Y-%m`
MAILTO=kav@at-consulting.ru
WORKDIR=/tmp/

case $1 in
'--help'|'-h'|'?')
	echo "Usage $0 esx-01.localdomain [-v]"
;;

*)

### Head 
echo " "
echo -e "Log analyz is starting.... \c"
date

if [ ! -d ${LOGDIR}/ ];then echo " " | mailx -s "ERROR: No DIR ${LOGDIR}" ${MAILTO}; fi

if [ -f ${LOGDIR}/${LOGNAME} ];then # If log files ${LOGDIR}/${LOGNAME} exist

if [ -f ${WORKDIR}/${HOST}_${LOGNAME}.new ];then
		mv ${WORKDIR}/${HOST}_${LOGNAME}.new ${WORKDIR}/${HOST}_${LOGNAME}.old; cp ${LOGDIR}/${LOGNAME} ${WORKDIR}/${HOST}_${LOGNAME}.new
		diff ${WORKDIR}/${HOST}_${LOGNAME}.new ${WORKDIR}/${HOST}_${LOGNAME}.old > ${WORKDIR}/newlines_${HOST}_${LOGNAME}
else
		cp ${LOGDIR}/${LOGNAME} ${WORKDIR}/${HOST}_${LOGNAME}.new
		cp ${WORKDIR}/${HOST}_${LOGNAME}.new ${WORKDIR}/newlines_${HOST}_${LOGNAME}
fi

perl -ne 'if ( ( /failed/i || /WARNING:\sNMP/ || /nmp_ThrottleLogForDevice:/ || /Waiting\sfor\stimed\sout/ || /iscsi_vmk/ ) && !/UserObj/ && !/naa.600508b1001c1fb6aad1c5ece2077388/ && !/naa.600508b1001cbad52462e647882124f0/ ) {print}' ${WORKDIR}/newlines_${HOST}_${LOGNAME} > ${WORKDIR}/${HOST}_SendToMail

# Notification
case $2 in
'-v')
	cat ${WORKDIR}/${HOST}_SendToMail;
;;
*)
	if [ -s ${WORKDIR}/${HOST}_SendToMail ];then cat ${WORKDIR}/${HOST}_SendToMail|mailx -s "Found `wc -l ${WORKDIR}/${HOST}_SendToMail | awk '{print $1}'`: ${HOST}" ${MAILTO}; fi
;;
esac

else
	echo "file ${LOGDIR}/${LOGNAME} does't exist..."
fi
;;

esac
