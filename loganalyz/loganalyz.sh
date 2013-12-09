#!/bin/bash

# Parameters
if [[ -z $1 ]];then echo "HOST is empty...";exit 1;else HOST=$1;fi

LOGNAME=vmkernel-`date +%Y-%m-%d`
LOGDIR=/zpool/${HOST}/`date +%Y-%m`
MAILTO=kav@at-consulting.ru
WORKDIR=/zpool/tmp/
SCRIPTDIR=/root/scripts/loganalyz

case $2 in
'-t')
	perl -ne 'if ( ( /failed/i || /WARNING:\sNMP/ || /nmp_ThrottleLogForDevice:/ || /Waiting\sfor\stimed\sout/ || /iscsi_vmk/ ) && !/UserObj/ && !/H:0x0 D:0x2 P:0x0/ ) {print}' ${LOGDIR}/${LOGNAME}
;;

*)

case $1 in
'--help'|'-h'|'?'|''|"[\ ]*")
	echo "Usage $0 esx-01.localdomain [-v]"
;;

*)

### Head 
echo " "
echo -e "[${HOST}] Log analyz is starting.... \c"
date

if [ ! -d ${LOGDIR}/ ];then 
	#echo " " | mailx -s "ERROR: No DIR ${LOGDIR}" ${MAILTO};
	echo "ERROR: No DIR ${LOGDIR}" 
 fi

if [ -f ${LOGDIR}/${LOGNAME} ];then # If log files ${LOGDIR}/${LOGNAME} exist

if [ -f ${WORKDIR}/${HOST}_${LOGNAME}.new ];then
		mv ${WORKDIR}/${HOST}_${LOGNAME}.new ${WORKDIR}/${HOST}_${LOGNAME}.old; cp ${LOGDIR}/${LOGNAME} ${WORKDIR}/${HOST}_${LOGNAME}.new
		diff ${WORKDIR}/${HOST}_${LOGNAME}.new ${WORKDIR}/${HOST}_${LOGNAME}.old > ${WORKDIR}/newlines_${HOST}_${LOGNAME}
else
		cp ${LOGDIR}/${LOGNAME} ${WORKDIR}/${HOST}_${LOGNAME}.new
		cp ${WORKDIR}/${HOST}_${LOGNAME}.new ${WORKDIR}/newlines_${HOST}_${LOGNAME}
fi

${SCRIPTDIR}/filter.pl ${HOST} ${WORKDIR}/newlines_${HOST}_${LOGNAME} ${WORKDIR}/${HOST}_SendToMail

# Notification
if [ -s ${WORKDIR}/${HOST}_SendToMail ];then cat ${WORKDIR}/${HOST}_SendToMail|mailx -s "Found `wc -l ${WORKDIR}/${HOST}_SendToMail | awk '{print $1}'`: ${HOST}" ${MAILTO}; fi

else
	echo "file ${LOGDIR}/${LOGNAME} does't exist..."
fi
;;

esac

;;
esac
