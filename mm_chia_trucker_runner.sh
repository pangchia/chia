#!/bin/bash

export dttimes=`date '+%Y-%m-%d %H:%M:%S'`
export dt=`date '+%Y-%m-%d'`

export log_root_path="/home/lubq/chia/mm_logs"
export trucking_log_file=${log_root_path}/${dt}_mm_trucking.log
export trucker_out_log_file=${log_root_path}/${dt}_mm_trucker_out.log

touch ${trucker_out_log_file}

nohup /usr/local/bin/mm_chia_trucker.sh $1 $2 $3 > tracker.out 2>&1 &
