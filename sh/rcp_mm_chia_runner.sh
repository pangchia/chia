#!/bin/bash

target_direction=$1
remote_hvst_ip=$2
remote_hvst_dir=$3

temp1_direction="/nvme01"
temp2_direction="/mnt/ramdisk"
log_root_path="/home/lubq/chia/mm_logs"

log_warn="WARN"
log_info="INFO"

# final plot 102G
final_plot_size=102
dttimes=`date '+%Y-%m-%d %H:%M:%S'`
dt=`date '+%Y-%m-%d'`
runner_log_file=`echo "${log_root_path}/${dt}_mm_runner.log"`
monitor_log_file=`echo "${log_root_path}/${dt}_mm_monitor.log"`

touch $runner_log_file
touch $monitor_log_file

chia_plot_filename="chia_plot_list.txt"
chia_plot_list_path=${log_root_path}
chia_plot_list_fullname=`echo "${chia_plot_list_path}/${dt}_${chia_plot_filename}"`

echo "remote harvester ip : ${remote_hvst_ip}"
echo "remote harvester dir : ${remote_hvst_dir}"

#remote_query_result=`ssh lubq@${remote_hvst_ip} "df -BG|grep '${remote_hvst_dir}' "`
#echo "remote query result : ${remote_query_result}"

#remote_disk_all=`echo ${remote_query_result} | awk -F' ' '{printf $2}' |  cut -d "G" -f1` 
#remote_disk_used=`echo ${remote_query_result} | awk -F' ' '{printf $3}' |  cut -d "G" -f1` 
#remote_disk_left=`echo ${remote_query_result} | awk -F' ' '{printf $4}' |  cut -d "G" -f1` 

#echo "remote_disk_all : ${remote_disk_all}"
#echo "remote_disk_used : ${remote_disk_used}"
#echo "remote_disk_left : ${remote_disk_left}"

# main func
start(){

  chiaPlotProcess=`ps -ef|grep "chia_plot" |  grep -v "grep" | awk -F' ' '{print $2}'`

  if [ ! -n "${chiaPlotProcess}" ] ; then

 	dest_message=`df -BG|grep "${target_direction}" |awk -F' ' '{printf $2 $3 $4}'`
	temp1_message=`df -BG|grep "${temp1_direction}" |awk -F' ' '{printf $2 $3 $4}'`
	temp2_message=`df -BG|grep "${temp2_direction}" |awk -F' ' '{printf $2 $3 $4}'`


 	all=`echo ${dest_message} | awk -F'G' '{printf $1}'`
 	used=`echo ${dest_message} | awk -F'G' '{printf $2}'`
 	left=`echo ${dest_message} | awk -F'G' '{printf $3}'`


	echo "${dttimes} temp1 msg:[${temp1_message}]      temp2 msg: [${temp2_message}]" >> $monitor_log_file

	temp1_used=`echo ${temp1_message} | awk -F'G' '{printf $2}'`
	temp2_used=`echo ${temp2_message} | awk -F'G' '{printf $2}'`



	echo "${dttimes} temp1 used:[${temp1_used}]      temp2 used:[ ${temp2_used}]" >> $monitor_log_file

 	echo "${dttimes} disk ${direction} all: ${all}, used: ${used}, left: ${left}, final_plot: ${final_plot_size}" >> $monitor_log_file



	if [ $temp1_used -ge 2 ]; then
	
		echo "${dttimes} ${log_warn} temp1_direction ${temp1_direction}  used: ${temp1_used}  try to clean" >> $monitor_log_file
		cd $temp1_direction
		rm *.tmp
		echo "${dttimes} ${log_warn} temp1_direction ${temp1_direction}  used: ${temp1_used}  clean done" >> $monitor_log_file
	else
		echo "temp1_direction ${temp1_direction}  used: ${temp1_used}  ready to plot" >> $monitor_log_file
	fi
	
	if [ $temp2_used -gt 0 ]; then

		echo "${dttimes} ${log_warn} temp2_direction ${temp2_direction}  used: ${temp2_used}  try to clean" >> $monitor_log_file
		cd $temp2_direction
                rm *.tmp
		echo "${dttimes} ${log_warn} temp2_direction ${temp2_direction}  used: ${temp2_used}  clean done" >> $monitor_log_file
	else
		echo "temp2_direction ${temp2_direction}  used: ${temp2_used}  ready to plot" >> $monitor_log_file
	fi 

 
	if [ $left -ge $final_plot_size ]; then
 
		echo "${dttimes} left: ${left}  permit : true , try chia_plot in ${direction}" >> $monitor_log_file

#		cd /usr/local/src/chia-plotter/build 


####  OG PLOTTER
#		nohup ./chia_plot -n 1 -r 16 -u 128 -t ${temp1_direction}/ -2 ${temp2_direction}/ -d ${target_direction}/ -f a2920a6b8e5ed1c6e5a7a3b9b53588d3328ad2a78ecfffb57f4a7425bc7d63e3720f64c7d06fc489926a0de8aa8211b9 -p 8bdf9b303e5723710d477af2eaf07b3e9a0141592fab541c06454a8a5e211a3106267a983eec3e91f323270e8b1bc24d >> $runner_log_file &

                cd /usr/local/src/pool-puzzles-chia-plotter/build

		echo "${dttimes} run shell chia_plot start >" >> $monitor_log_file


#### NFT PLOTTER
		nohup ./chia_plot -n 1 -r 16 -u 128 -t ${temp1_direction}/ -2 ${temp2_direction}/ -d ${target_direction}/ -f a2920a6b8e5ed1c6e5a7a3b9b53588d3328ad2a78ecfffb57f4a7425bc7d63e3720f64c7d06fc489926a0de8aa8211b9 -c xch1dsvvmhjj6vv87am68lhkxve56x33tdz55tl28v65zfmxvr53z7wqhkrjde >> $runner_log_file &


		echo "${dttimes} run shell chia_plot end   <" >> $monitor_log_file

		if [ ! -e "${chia_plot_list_fullname}" ]; then 
			echo "${dttimes} create new chia_plot_list [${chia_plot_list_fullname}]" >> $monitor_log_file
			touch $chia_plot_list_fullname 
		fi 

		cd $target_direction
		last_file_name=`ls -alt | grep "^-" | grep ".plot$" |head -n 1 |awk -F' ' '{printf $9}'`
                # echo "${dttimes} lastest file ${last_file_name} ready to copy ${remote_hvst_ip}:${remote_hvst_dir}" >> $monitor_log_file


		plot_not_exist=1

		for plot_name in $(cat ${chia_plot_list_fullname} );
		do
			echo "find plot_name:${plot_name}"  >> $monitor_log_file
			if [ "${plot_name}" -eq "${last_file_name}"]; then
				plot_not_exist=0
			fi
		done


		if [ $plot_not_exist == 1 ]; then

			echo "remote harvester ip : ${remote_hvst_ip}"  >> $monitor_log_file
			echo "remote harvester dir : ${remote_hvst_dir}"  >> $monitor_log_file

			remote_query_result=`ssh lubq@${remote_hvst_ip} "df -BG|grep '${remote_hvst_dir}' "`
			echo "remote query result : ${remote_query_result}"  >> $monitor_log_file

			remote_disk_all=`echo ${remote_query_result} | awk -F' ' '{printf $2}' |  cut -d "G" -f1`
			remote_disk_used=`echo ${remote_query_result} | awk -F' ' '{printf $3}' |  cut -d "G" -f1`
			remote_disk_left=`echo ${remote_query_result} | awk -F' ' '{printf $4}' |  cut -d "G" -f1`

			echo "remote_disk_all : ${remote_disk_all}"  >> $monitor_log_file
			echo "remote_disk_used : ${remote_disk_used}"  >> $monitor_log_file
			echo "remote_disk_left : ${remote_disk_left}"  >> $monitor_log_file

			if [ $remote_disk_left  -ge $final_plot_size ]; then

		        	echo "${dttimes} lastest file ${last_file_name} is ready copy to ${remote_hvst_ip}:${remote_hvst_dir}" >> $monitor_log_file
				# scp to remote hvst                                            
	                        scp $last_file_name -p -q -l 850000 lubq@${remote_hvst_ip}:${remote_hvst_dir}
				echo "${last_file_name}" >> $chia_plot_list_fullname
				echo "${dttimes} ${last_file_name} remote copy < ${remote_hvst_ip}:${remote_hvst_dir}> finished"  >> $monitor_log_file
			else
				echo "${dttimes} ${log_warn} ${remote_hvst_ip}:${remote_hvst_dir} have not enough space for ${last_file_name}, abort copy ..." >> $monitor_log_file
			fi
			
		else
			echo "${dttimes} ${log_warn} lastest file ${last_file_name} had already copied to ${remote_hvst_ip}:${remote_hvst_dir}" >> $monitor_log_file

		fi


	else
 		echo "${dttimes} ${log_warn} left: ${left},  permit : false, shell will return ..." >> $monitor_log_file
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


# if [[ $cpu_use -ge 80 ]];then
# for email in $emails
#  do echo "阿里云服务器 在$dtimes CPU 使用：$cpu_use%  过去1分钟、5分钟、15分钟CPU平均值为：$cpu_average" | mail -s "CPU告警" $email;done;
# fi

# last_average=`echo ${cpu_average} | awk -F ',' '{printf $1}'`

#echo "cpu_average"
#echo ${cpu_average}
#echo "last_average"
#echo $last_average

# if [[ `echo "0.99 1" | awk '{print ($1 > $2)}'` == 1 ]]; then
#  echo "0.99 is greater than 1"
# else
#  echo "0.99 is smaller than 1"
# fi
 

# if [[ `echo "$last_average 2" | awk '{print ($1 > $2)}'` == 1 ]];then
# for email in $emails
#  do echo "阿里云服务器 在$dtimes CPU load average:$last_average cpu_average:$cpu_average !" | mail -s "CPU load average 告警" $email;done;
# fi

}



if [ ! -n "$1" ] || [ ! -n "$2" ] || [ ! -n "$3" ];then
  echo "${dttimes}  ${log_info} not input onf of <target_direction or remote_hvst_ip or remote_hvst_ip>, shell will return." >> $monitor_log_file

else
  start
fi
