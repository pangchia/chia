#!/bin/bash

dttimes=`date '+%Y-%m-%d %H:%M:%S'`

dt=`date '+%Y-%m-%d'`

disk_list=`df -h -t 'ext4' --output=source | awk '{if(NR>1)print}'`

log_root_path="/home/lubq/chia/disk_monitor_logs"

log_file=`echo "${log_root_path}/${dt}_monitor_disk.log"`

ALERT_LEVEL=45


# main func
function start(){

	if [ ! -d $log_root_path ]; then
		mkdir $log_root_path
	fi

	if [ ! -e $log_file ]; then
		touch $log_file
	fi

	fire_alert=0

	for disk in $disk_list
	do
		if [ -b $disk ]; then
			dtemp=`hddtemp /dev/sda | awk '{ print $4}' | awk -F '°' '{ print $1}'`
			
			if [ $dtemp -gt $ALERT_LEVEL ]; then
				
				serialNo=`hdparm -i ${disk} | grep SerialNo | awk -F'SerialNo=' '{printf $2}'`
				hname=`hostnamectl |grep hostname | awk -F'hostname: ' '{printf $2}'`
				ip=`ifconfig |grep -v '127.0.0.1' |grep -E 'inet .*netmask.*broadcast'  |awk -F' ' '{printf $2}'`
				message="ip:${ip} \npc name:${hname} \nmount:${disk} \nsn:${serialNo} \ntemp:$dtemp"
				echo $message

				callback=`curl http://wxpusher.zjiecode.com/api/send/message -X POST -d '{"appToken":"AT_qHhCuJsagWTzonnc8rDokBTFglXdZnZX","content":"'"磁盘报警\n${message}"'","contentType":"1", "uids":["UID_0cTzfbaZJ8xS2WquTuZdkgqpUxWA"] }' --header "Content-Type: application/json" --silent --output /dev/null`
			
				
				fire_alert=1
			fi
		fi
	done

	if [ $fire_alert == 0 ]; then
		echo "${dttimes} all disks temperature stay low , warning line ${ALERT_LEVEL}" >> $log_file

	fi
}

start
