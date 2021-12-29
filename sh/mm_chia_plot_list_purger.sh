#!/bin/bash

export dttimes=`date '+%Y-%m-%d_%H:%M:%S'`
export dt=`date '+%Y-%m-%d'`

export log_root_path="/home/lubq/chia/mm_logs"
export log_bak_path="${log_root_path}_backup"
export log_bak_default_suffix="purge_chia_list_backup.txt"
export purger_log_file=${log_root_path}/${dt}_mm_purger.log



touch ${purger_log_file}

purge_file=$1
purge_line=$2

#echo $purge_file
#echo $purge_line

function start (){
	count=`cat ${purge_file} |wc -l`
#	echo "${purge_file}  count:${count}"
	
	if [ $count -gt $purge_line ]; then

		if [ ! -d $log_bak_path ]; then
			mkdir $log_bak_path
		fi

		cp ${purge_file} ${log_bak_path}/${dttimes}_${log_bak_default_suffix}

		sed -i '1,'"${purge_line}"'d' ${purge_file}

		echo "${dttimes} purge head ${purge_line} lines" >> ${purger_log_file}

	else
		echo "${dttimes} not much to purge " >> ${purger_log_file}
	fi	

}


start



