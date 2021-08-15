#!/bin/bash

target_direction=$1

temp1_direction="/nvme01"
temp2_direction="/mnt/ramdisk" 
log_root_path="/home/lubq/chia/mm_logs"

log_warn="WARN"
log_info="INFO"

local_server_name="X99_192.168.3.5"

# final plot 102G
final_plot_size=102

# disk usedPercent alert
#disk_used_percent_threshold=85
disk_used_percent_threshold=80

dttimes=`date '+%Y-%m-%d %H:%M:%S'`
dt=`date '+%Y-%m-%d'`
runner_log_file=`echo "${log_root_path}/${dt}_mm_runner.log"`
monitor_log_file=`echo "${log_root_path}/${dt}_mm_monitor.log"`
err_log_file="${log_root_path}/${dt}_mm_err_runner.log"

touch $runner_log_file
touch $monitor_log_file

# main func
function start(){

   chiaPlotProcess=`ps -ef|grep "chia_plot" |  grep -v grep | awk -F' ' '{print $2}'`
   
  if [[ ! -n "${chiaPlotProcess}" ]] ; then

 	dest_message=`df -BG|grep "${target_direction}" |awk -F' ' '{printf "%s%s%s%s", $2, $3, $4, $5"%"}'`
	temp1_message=`df -BG|grep "${temp1_direction}" |awk -F' ' '{printf $2 $3 $4}'`
	temp2_message=`df -BG|grep "${temp2_direction}" |awk -F' ' '{printf $2 $3 $4}'`

 	all=`echo ${dest_message} | awk -F'G' '{printf $1}'`
 	used=`echo ${dest_message} | awk -F'G' '{printf $2}'`
 	left=`echo ${dest_message} | awk -F'G' '{printf $3}'`
	perc=`echo ${dest_message} | awk -F'G' '{printf $4}' | cut -d "%" -f1`

	echo "${dttimes} temp1 msg:[${temp1_message}]      temp2 msg: [${temp2_message}]" >> $monitor_log_file

	temp1_used=`echo ${temp1_message} | awk -F'G' '{printf $2}'`
	temp2_used=`echo ${temp2_message} | awk -F'G' '{printf $2}'`



	echo "${dttimes} temp1 used:[${temp1_used}]      temp2 used:[ ${temp2_used}]" >> $monitor_log_file

 	echo "${dttimes} disk ${direction} all: ${all}, used: ${used}, left: ${left}, usedPercent: ${perc}%, final_plot: ${final_plot_size}" >> $monitor_log_file



	if [[ $temp1_used -ge 2 ]]; then
	
		echo "${dttimes} ${log_warn} temp1_direction ${temp1_direction}  used: ${temp1_used}  try to clean" >> $monitor_log_file
		cd $temp1_direction
		rm *.tmp
		echo "${dttimes} ${log_warn} temp1_direction ${temp1_direction}  used: ${temp1_used}  clean done" >> $monitor_log_file
	else
		echo "temp1_direction ${temp1_direction}  used: ${temp1_used}  ready to plot" >> $monitor_log_file
	fi
	
	if [[ $temp2_used -gt 0 ]]; then

		echo "${dttimes} ${log_warn} temp2_direction ${temp2_direction}  used: ${temp2_used}  try to clean" >> $monitor_log_file
		cd $temp2_direction
                rm *.tmp
		echo "${dttimes} ${log_warn} temp2_direction ${temp2_direction}  used: ${temp2_used}  clean done" >> $monitor_log_file
	else
		echo "temp2_direction ${temp2_direction}  used: ${temp2_used}  ready to plot" >> $monitor_log_file
	fi 

	if [ $perc -gt $disk_used_percent_threshold ]; then
		percent_message="server name: ${local_server_name} \nused percent: ${perc}"
		callback=`curl http://wxpusher.zjiecode.com/api/send/message -X POST -d '{"appToken":"AT_qHhCuJsagWTzonnc8rDokBTFglXdZnZX","content":"'"磁盘报警\n${percent_message}"'","contentType":"1", "uids":["UID_0cTzfbaZJ8xS2WquTuZdkgqpUxWA"] }' --header "Content-Type: application/json" --silent --output /dev/null`
		echo "${dttimes} ${log_warn} wx push callback : ${callback}" >> $monitor_log_file
	fi
 
	if [[ $left -ge $final_plot_size ]]; then
 
		echo "${dttimes} left: ${left}  permit : true , try chia_plot in ${direction}" >> $monitor_log_file

#		cd /usr/local/src/chia-plotter/build 

#		nohup ./chia_plot -n 1 -r 16 -u 128 -t ${temp1_direction}/ -2 ${temp2_direction}/ -d ${target_direction}/ -f a2920a6b8e5ed1c6e5a7a3b9b53588d3328ad2a78ecfffb57f4a7425bc7d63e3720f64c7d06fc489926a0de8aa8211b9 -p 8bdf9b303e5723710d477af2eaf07b3e9a0141592fab541c06454a8a5e211a3106267a983eec3e91f323270e8b1bc24d >> $runner_log_file &

                cd /usr/local/src/pool-puzzles-chia-plotter/build

		nohup ./chia_plot -n 1 -r 16 -u 128 -t ${temp1_direction}/ -2 ${temp2_direction}/ -d ${target_direction}/ -f a2920a6b8e5ed1c6e5a7a3b9b53588d3328ad2a78ecfffb57f4a7425bc7d63e3720f64c7d06fc489926a0de8aa8211b9 -c xch1dsvvmhjj6vv87am68lhkxve56x33tdz55tl28v65zfmxvr53z7wqhkrjde >> $runner_log_file 2>$err_log_file &


		echo "${dttimes} ${log_info} create a chia plot successful." >> $monitor_log_file
	else
 		echo "${dttimes} left: ${left},  permit : false, shell will return ..." >> $monitor_log_file
	fi

  else
	echo "${dttimes} Have another chia process: <${chiaPlotProcess}> shell will return ..." >> $monitor_log_file
  fi



# for partition  in `df -h | grep -v "tmpfs" |grep -v "Filesystem" | awk '{printf $5}' | sed 's/%/\n/g'`
# do
#   if [[ $partition -ge $ratio ]];then
#     for email in  $emails
#     do echo "阿里云服务器 在$dtimes 磁盘已使用: $partition" | mail -s "磁盘告警" $email; done;
#   fi
# done

}


if [ ! -n "$1" ] ;then
  echo "${dttimes} no input <target direction> shell will return." >> $monitor_log_file
else
  start
fi
