#!/bin/bash
# Store configuration files
#
for H in `/bin/ls -1 cfgs/*`;do

	cfg_HOST=`basename $H`
	for C in `cat ${H}|grep -v ^#`;do
		cfg_TYPE=`echo $C|awk -F: '{print $1}'`
		cfg_USER=`echo $C|awk -F\: '{print $2}'`
		cfg=`echo $C|awk -F\: '{print $3}'`
		if [ "${cfg_TYPE}" == "d" ];then
			cfg="${cfg}/";
		fi;
		cfg_ALL=`echo "${cfg}"|sed 's/\*//g'`

		if [ "${cfg_TYPE}" == "f" ];then
			cfg_PATH=`dirname ${cfg_ALL}`;
		else
			cfg_PATH="${cfg_ALL}/";
		fi
			
		cfg_STORE_PATH=data/${cfg_HOST}/${cfg_PATH};

		if [ ! -d ${cfg_STORE_PATH} ];then 
			mkdir -p ${cfg_STORE_PATH};
		fi;
	
		echo "rsync -rlptgoD ${cfg_USER}@${cfg_HOST}:${cfg} ${cfg_STORE_PATH}"
		rsync -rlptgoD ${cfg_USER}@${cfg_HOST}:${cfg} ${cfg_STORE_PATH}
	done

done
