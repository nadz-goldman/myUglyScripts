!/mnt/HD/HD_a2/ffp/bin/bash

#
# Script for RRD
#

run_proc=$( cat /proc/loadavg | tr \/ " " | awk {'print $4'} )
tot_proc=$( cat /proc/loadavg | tr \/ " " | awk {'print $5'} )

loadavg_1min=$( cat /proc/loadavg | awk {'print $1'} )
loadavg_5min=$( cat /proc/loadavg | awk {'print $2'} )

uptime=$(</proc/uptime)
uptime=${uptime%%.*}
days_uptime=$(( uptime/60/60/24 ))

DATA=`vmstat 1 1 | tail -n1`
cpu_user=$( echo $DATA | awk '{print $14}' )
cpu_sys=$( echo $DATA | awk '{print $13}' )

DATA=`free -m | grep Mem`
mem_tot=$( echo $DATA | awk '{print $2}' )
mem_used=$( echo $DATA | awk '{print $3}' )

in_temp=$(fan_control -g 0 | awk '{print $4}')

/opt/bin/rrdtool update /mnt/HD/HD_a2/myScripts/bin/stats/rrd/cpu_mem_proc_uptime_temp.rrd N:$run_proc:$tot_proc:$loadavg_1min:$loadavg_5min:$cpu_user:$cpu_sys:$mem_tot:$mem_used:$days_uptime:$in_temp

net_estab=$( /usr/bin/netstat -nt | grep CLOSE_W | wc -l )
net_close=$( /usr/bin/netstat -nt | grep ESTABLISHED | wc -l )

DATA=`grep egiga0 /proc/net/dev`
net_giga_rx=$( echo $DATA | awk '{print $2}' )
net_giga_tx=$( echo $DATA | awk '{print $10}' )

trans_down=$( grep downloaded /mnt/HD/HD_a2/.systemfile/P2P/.settings/stats.json | awk {'print $2'} | tr , " " )
trans_upl=$( grep uploaded /mnt/HD/HD_a2/.systemfile/P2P/.settings/stats.json | awk {'print $2'} | tr , " " )
let "trans_down = $trans_down / 1073741824"
let "trans_upl = $trans_upl / 1073741824"

disk_used=$( df | grep md1 | awk {'print $3'} )
disk_avail=$( df | grep md1 | awk {'print $4'} )
let "disk_used = $disk_used / 100000"
let "disk_avail = $disk_avail / 100000"

/opt/bin/rrdtool update /mnt/HD/HD_a2/myScripts/bin/stats/rrd/net_disk.rrd N:$net_estab:$net_close:$net_giga_rx:$net_giga_tx:$trans_down:$trans_upl:$disk_used:$disk_avail

ULMM=$( /opt/bin/curl -s -L "https://api.openweathermap.org/data/2.5/weather?id=524305&appid=SECRET-TOKEN&units=metric" | sed -e 's/[{}]/''/g' | awk -v RS=',"' -F: '/^temp_min/ {print $2}' )
ULLI=$( /opt/bin/curl -s -L "https://api.openweathermap.org/data/2.5/weather?id=536203&appid=SECRET-TOKEN&units=metric" | sed -e 's/[{}]/''/g' | awk -v RS=',"' -F: '/^temp_min/ {print $2}' )

/opt/bin/rrdtool update /mnt/HD/HD_a2/myScripts/bin/stats/rrd/temp.rrd N:$ULMM:$ULLI

