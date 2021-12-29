#!/bin/bash

export dttimes=`date '+%Y-%m-%d_%H:%M:%S'`
export dt=`date '+%Y-%m-%d'`

export log_root_path="/home/lubq/chia/mm_logs"
export zombie_log_file=${log_root_path}/${dt}_mm_zombie_defunct.log



touch ${zombie_log_file}

function start (){
	
	zombie1=`ps axo stat,ppid,pid,comm | grep -w defunct`
#	zombie2=`ps -A -o stat,ppid,pid,cmd | grep -e '^[Zz]'`


	
	if [ -n "${zombie1}" ] ; then

		echo "${dttimes} found zombie process [ ${zombie1} ]" >> ${zombie_log_file}

		# wx
		callback=`curl http://wxpusher.zjiecode.com/api/send/message -X POST -d '{"appToken":"AT_qHhCuJsagWTzonnc8rDokBTFglXdZnZX","content":"'"僵尸进程报警\n${zombie1}"'","contentType":"1", "uids":["UID_0cTzfbaZJ8xS2WquTuZdkgqpUxWA"] }' --header "Content-Type: application/json" --silent --output /dev/null`
	        
		echo "${dttimes} WARN wx push callback : ${callback}" >> $zombie_log_file

	
	fi	

}


start



