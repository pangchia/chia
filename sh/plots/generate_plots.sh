#!/bin/bash


dttimes=`date '+%Y-%m-%d %H:%M:%S'`
dt=`date '+%Y-%m-%d'`
this_ip=`hostname -I |awk -F' ' '{print $1}'`
plots_path="/home/lubq/chia/plots"

        if [ ! -e "${plots_path}" ]; then
		mkdir -p ${plots_path}

	fi
	
	 curl --insecure --cert /root/.chia/mainnet/config/ssl/harvester/private_harvester.crt --key /root/.chia/mainnet/config/ssl/harvester/private_harvester.key -d '{"":""}' -H "Content-Type: application/json" -X POST https://localhost:8560/get_plots |jq -r '.plots[]|[.plot_id, .filename] |@csv' > ${plots_path}/get_${this_ip}_plots.txt

	 echo "${this_ip} get plots finished"

