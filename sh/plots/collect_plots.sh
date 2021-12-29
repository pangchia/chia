#!/bin/bash


dttimes=`date '+%Y-%m-%d %H:%M:%S'`
dt=`date '+%Y-%m-%d'`
harvester_ip_list=`echo "/home/lubq/chia/harvester.list"`
collect_path="/home/lubq/chia/plots/collect"



   /usr/local/bin/generate_plots_list.sh


   echo "=======> generate plots list finished ."
   sleep 2


   for harvester_ip in $(cat ${harvester_ip_list} );
   do

	if [ ! -e "${collect_path}" ]; then
		mkdir -p ${collect_path}
																            fi

	scp root@${harvester_ip}:/home/lubq/chia/plots/get_${harvester_ip}_plots.txt ${collect_path}
	sleep 2
	echo "=======> copy finished from ${harvester_ip} ."
   done
