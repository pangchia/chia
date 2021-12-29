#!/bin/bash

target_direction=$1 
remote_hvst_ip=$2
remote_hvst_dir=$3

#dttimes=`date '+%Y-%m-%d %H:%M:%S'`
#dt=`date '+%Y-%m-%d'`

#log_root_path="/home/lubq/chia/mm_logs"
#trucking_log_file=${log_root_path}/${dt}_mm_trucking.log

log_warn="WARN"
log_info="INFO"

# final plot 102G
plot_size_threshold=101
final_plot_size=102

touch $trucking_log_file

chia_plot_filename="chia_plot_list.txt"
chia_plot_list_path=${log_root_path}
chia_plot_list_fullname=${chia_plot_list_path}/${chia_plot_filename}

scp_cmd_key="scp -p -q -l"

touch ${chia_plot_list_fullname}

echo "-----  ${dttimes} -----" >> $trucking_log_file

# main func
start(){




	copyPlotProcess=`ps -ef|grep "${scp_cmd_key}" |  grep -v grep | awk -F' ' '{print $2}'`

	if [ ! -n "${copyPlotProcess}" ] ; then

		cd $target_direction
		last_file_message=`ls -alrt | grep "^-" | grep ".plot$" |head -n 1`
		last_file_size=`echo ${last_file_message} |awk -F' ' '{printf $5}'`
		last_file_name=`echo ${last_file_message} |awk -F' ' '{printf $9}'`

		plot_not_exist=1

		if [  -n "$last_file_name" ]; then

			for plot_name in $(cat ${chia_plot_list_fullname} );
			do
				
				if [ "${plot_name}" == "${last_file_name}" ]; then
					plot_not_exist=0
					echo "find plot_name:${plot_name} in ${chia_plot_list_fullname}"  >> $trucking_log_file
				fi
			done

			# not in list
			if [ $plot_not_exist == 1 ]; then

				remote_query_result=`ssh lubq@${remote_hvst_ip} "df -BG|grep '${remote_hvst_dir}' "`
				echo "remote query disk result : ${remote_query_result}"  >> $trucking_log_file

				remote_disk_all=`echo ${remote_query_result} | awk -F' ' '{printf $2}' |  cut -d "G" -f1`
				remote_disk_used=`echo ${remote_query_result} | awk -F' ' '{printf $3}' |  cut -d "G" -f1`
				remote_disk_left=`echo ${remote_query_result} | awk -F' ' '{printf $4}' |  cut -d "G" -f1`

				echo "remote_disk_all : ${remote_disk_all}"  >> $trucking_log_file
				echo "remote_disk_used : ${remote_disk_used}"  >> $trucking_log_file
				echo "remote_disk_left : ${remote_disk_left}"  >> $trucking_log_file

				if [ $remote_disk_left -ge $final_plot_size ]; then

			        	echo "${dttimes} lastest file ${last_file_name} is ready copy to ${remote_hvst_ip}:${remote_hvst_dir}" >> $trucking_log_file
					# scp to remote hvst                                            
					tmp_name="${last_file_name}.tmp"
		            		scp -p -q -l 850000 $target_direction/$last_file_name root@${remote_hvst_ip}:${remote_hvst_dir}/$tmp_name
					# after finish
					echo "${last_file_name}" >> $chia_plot_list_fullname
					echo "${dttimes} ${last_file_name} remote copy < ${remote_hvst_ip}:${remote_hvst_dir}> finished"  >> $trucking_log_file

					# rename to *.plot
					ssh root@${remote_hvst_ip} "mv ${remote_hvst_dir}/${tmp_name} ${remote_hvst_dir}/${last_file_name}"
					echo "${dttimes} rename remote ${tmp_name} to ${last_file_name}"  >> $trucking_log_file
					remote_copy_plot_message=`ssh root@${remote_hvst_ip} "ls -l ${remote_hvst_dir}/${last_file_name}"`
					# echo "message ${remote_copy_plot_message} "
					remote_copy_plot_size=`echo ${remote_copy_plot_message}  | awk -F' ' '{printf $5}'`

					# echo "message ${remote_copy_plot_size} "

					if [ ! -n "$remote_copy_plot_size" ] || [ ${last_file_size} != ${remote_copy_plot_size} ] ; then
						echo "${dttimes} ${log_warn} ${last_file_name} local size: ${} remote size: ${} not same !!!  remote: ${remote_hvst_ip}:${remote_hvst_dir}"  >> $trucking_log_file
					else
						echo "${dttimes} ${last_file_name} local size: ${last_file_size}, remote size: $remote_copy_plot_size, scp finished . try to remove local file ..."  >> $trucking_log_file
						rm ${last_file_name}
						echo "${dttimes} ${last_file_name} remove finished"  >> $trucking_log_file
					fi
					
				else
					echo "${dttimes} ${log_warn} ${remote_hvst_ip}:${remote_hvst_dir} have not enough space for ${last_file_name}, abort copy ..." >> $trucking_log_file
				fi
				
			else
				echo "${dttimes} ${log_warn} lastest file ${last_file_name} had already copied to ${remote_hvst_ip}:${remote_hvst_dir}" >> $trucking_log_file
			fi
		else
			echo "${dttimes} no file need trucking to ${remote_hvst_ip}:${remote_hvst_dir}" >> $trucking_log_file
		fi
	else
		echo "${dttimes} is running copy to ${remote_hvst_ip}:${remote_hvst_dir}" >> $trucking_log_file
	fi
}



if [ ! -n "$1" ] || [ ! -n "$2" ] || [ ! -n "$3" ];then
  echo "${dttimes}  ${log_info} not input one of <target_direction or remote_hvst_ip or remote_hvst_ip>, shell will return." >> $trucking_log_file
else
  start
fi
