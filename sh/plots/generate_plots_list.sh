#!/bin/bash


dttimes=`date '+%Y-%m-%d %H:%M:%S'`
dt=`date '+%Y-%m-%d'`
harvester_ip_list=`echo "/home/lubq/chia/harvester.list"`

   for harvester_ip in $(cat ${harvester_ip_list} );
   do
		
	 #  curl --insecure --cert /home/lubq/chia/crts/${harvester_ip}/private_harvester.crt --key /home/lubq/chia/crts/${harvester_ip}/private_harvester.key -d '{"":""}' -H "Content-Type: application/json" -X POST https://${harvester_ip}:8560/get_plots | jq '.plots[].filename' > /home/lubq/chia/plots/get_${harvester_ip}_plots.txt
	  


	 remote_query_result=`ssh root@${harvester_ip} "/usr/local/bin/generate_plots.sh;"`



	sleep 3
	echo "=======> generate ${harvester_ip} plots list done !"
   done
