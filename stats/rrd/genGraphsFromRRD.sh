#!/mnt/HD/HD_a2/ffp/bin/bash

#
# Script generating RRD GRAPH
#


cd /mnt/HD/HD_a2/myScripts/bin/stats/rrd


DAYS="1h 6h 1d 7d 30d 1y"
DATE="`date '+%d-%m-%Y %H\:%M\:%S'`"
GRAPHS_PATH="/mnt/HD/HD_a2/myScripts/web/mrtg/graphs"

for day in $DAYS; do

/opt/bin/rrdtool graph "$GRAPHS_PATH/proc-${day}.png" \
              --start end-${day} --slope-mode \
              --title "Processes: runninng and total" \
              --width 600 --height 200 \
              --imgformat PNG \
          DEF:a_avg=cpu_mem_proc_uptime_temp.rrd:run_proc:AVERAGE \
          DEF:a_max=cpu_mem_proc_uptime_temp.rrd:run_proc:MAX \
          DEF:a_min=cpu_mem_proc_uptime_temp.rrd:run_proc:MIN \
          DEF:b_avg=cpu_mem_proc_uptime_temp.rrd:tot_proc:AVERAGE \
          DEF:b_max=cpu_mem_proc_uptime_temp.rrd:tot_proc:MAX \
          DEF:b_min=cpu_mem_proc_uptime_temp.rrd:tot_proc:MIN \
          AREA:a_avg#3366ff:"Running processes " \
          LINE1:a_avg#1a53ff \
          GPRINT:a_max:MAX:"MAX %6.0lf" \
          GPRINT:a_min:MIN:"MIN %6.0lf" \
          GPRINT:a_avg:AVERAGE:"AVG %6.0lf\n" \
          AREA:b_avg#809fff:"Total processes   " \
          LINE1:b_avg#002080 \
          GPRINT:b_max:MAX:"MAX %6.0lf" \
          GPRINT:b_min:MIN:"MIN %6.0lf" \
          GPRINT:b_avg:AVERAGE:"AVG %6.0lf" \
          # > /dev/null 2>&1


/opt/bin/rrdtool graph "$GRAPHS_PATH/loadavg-${day}.png" \
              --start end-${day} --slope-mode \
              --title "loadavg 1 and 5 minutes" \
              --width 600 --height 200 \
              --imgformat PNG \
          DEF:a_avg=cpu_mem_proc_uptime_temp.rrd:loadavg_1min:AVERAGE \
          DEF:a_max=cpu_mem_proc_uptime_temp.rrd:loadavg_1min:MAX \
          DEF:a_min=cpu_mem_proc_uptime_temp.rrd:loadavg_1min:MIN \
          DEF:b_avg=cpu_mem_proc_uptime_temp.rrd:loadavg_5min:AVERAGE \
          DEF:b_max=cpu_mem_proc_uptime_temp.rrd:loadavg_5min:MAX \
          DEF:b_min=cpu_mem_proc_uptime_temp.rrd:loadavg_5min:MIN \
          AREA:a_avg#3366ff:"loadavg 1 min " \
          LINE1:a_avg#1a53ff \
          GPRINT:a_max:MAX:"MAX  %2.4lf" \
          GPRINT:a_min:MIN:"MIN  %2.4lf" \
          GPRINT:a_avg:AVERAGE:"AVG  %2.4lf\n" \
          AREA:b_avg#809fff:"loadavg 5 min " \
          LINE1:b_avg#002080 \
          GPRINT:b_max:MAX:"MAX  %2.4lf" \
          GPRINT:b_min:MIN:"MIN  %2.4lf" \
          GPRINT:b_avg:AVERAGE:"AVG  %2.4lf" \
          # > /dev/null 2>&1

/opt/bin/rrdtool graph "$GRAPHS_PATH/cpu-${day}.png" \
              --start end-${day} --slope-mode \
              --title "cpu user and system" \
              --width 600 --height 200 \
              --imgformat PNG \
          DEF:a_avg=cpu_mem_proc_uptime_temp.rrd:cpu_user:AVERAGE \
          DEF:a_max=cpu_mem_proc_uptime_temp.rrd:cpu_user:MAX \
          DEF:a_min=cpu_mem_proc_uptime_temp.rrd:cpu_user:MIN \
          DEF:b_avg=cpu_mem_proc_uptime_temp.rrd:cpu_sys:AVERAGE \
          DEF:b_max=cpu_mem_proc_uptime_temp.rrd:cpu_sys:MAX \
          DEF:b_min=cpu_mem_proc_uptime_temp.rrd:cpu_sys:MIN \
          AREA:a_avg#3366ff:"cpu usr " \
          LINE1:a_avg#1a53ff \
          GPRINT:a_max:MAX:"MAX  %6.0lf" \
          GPRINT:a_min:MIN:"MIN  %6.0lf" \
          GPRINT:a_avg:AVERAGE:"AVG  %6.0lf\n" \
          AREA:b_avg#809fff:"cpu sys " \
          LINE1:b_avg#002080 \
          GPRINT:b_max:MAX:"MAX  %6.0lf" \
          GPRINT:b_min:MIN:"MIN  %6.0lf" \
          GPRINT:b_avg:AVERAGE:"AVG  %6.0lf" \
          # > /dev/null 2>&1

/opt/bin/rrdtool graph "$GRAPHS_PATH/mem-${day}.png" \
              --start end-${day} --slope-mode \
              --title "memory: total and used" \
              --width 600 --height 200 \
              --imgformat PNG \
          DEF:a_avg=cpu_mem_proc_uptime_temp.rrd:mem_tot:AVERAGE \
          DEF:a_max=cpu_mem_proc_uptime_temp.rrd:mem_tot:MAX \
          DEF:a_min=cpu_mem_proc_uptime_temp.rrd:mem_tot:MIN \
          DEF:b_avg=cpu_mem_proc_uptime_temp.rrd:mem_used:AVERAGE \
          DEF:b_max=cpu_mem_proc_uptime_temp.rrd:mem_used:MAX \
          DEF:b_min=cpu_mem_proc_uptime_temp.rrd:mem_used:MIN \
          AREA:a_avg#3366ff:"memory total " \
          LINE1:a_avg#1a53ff \
          GPRINT:a_max:MAX:"MAX  %4.2lf" \
          GPRINT:a_min:MIN:"MIN  %4.2lf" \
          GPRINT:a_avg:AVERAGE:"AVG  %4.2lf\n" \
          AREA:b_avg#809fff:"memory used  " \
          LINE1:b_avg#002080 \
          GPRINT:b_max:MAX:"MAX  %4.2lf" \
          GPRINT:b_min:MIN:"MIN  %4.2lf" \
          GPRINT:b_avg:AVERAGE:"AVG  %4.2lf" \
          # > /dev/null 2>&1


/opt/bin/rrdtool graph "$GRAPHS_PATH/uptime-${day}.png" \
              --start end-${day} --slope-mode \
              --title "uptime" \
              --width 600 --height 200 \
              --imgformat PNG \
          DEF:a_min=cpu_mem_proc_uptime_temp.rrd:uptime:MAX \
          AREA:a_min#3366ff:"uptime " \
          LINE1:a_min#1a53ff \
          GPRINT:a_min:MAX:"uptime %4.2lf" \
          # > /dev/null 2>&1


/opt/bin/rrdtool graph "$GRAPHS_PATH/chasis_temp-${day}.png" \
              --start end-${day} --slope-mode \
              --title "temperature in chasis" \
              --width 600 --height 200 \
              --imgformat PNG \
          DEF:a_avg=cpu_mem_proc_uptime_temp.rrd:chasis_temp:AVERAGE \
          DEF:a_min=cpu_mem_proc_uptime_temp.rrd:chasis_temp:MIN \
          DEF:a_max=cpu_mem_proc_uptime_temp.rrd:chasis_temp:MAX \
          AREA:a_max#3366ff:"Temperature in chasis " \
          LINE1:a_max#1a53ff \
          GPRINT:a_avg:AVERAGE:"temperature %2.2lf" \
          GPRINT:a_max:MAX:"MAX  %2.2lf" \
          GPRINT:a_min:MIN:"MIN  %2.2lf" \
          # > /dev/null 2>&1


# net connections
/opt/bin/rrdtool graph "$GRAPHS_PATH/net-conn-${day}.png" \
              --start end-${day} --slope-mode \
              --title "netstat: established and close_wait" \
              --width 600 --height 200 \
              --imgformat PNG \
          DEF:a_avg=net_disk.rrd:net_estab:AVERAGE \
          DEF:a_max=net_disk.rrd:net_estab:MAX \
          DEF:a_min=net_disk.rrd:net_estab:MIN \
          DEF:b_avg=net_disk.rrd:net_close:AVERAGE \
          DEF:b_max=net_disk.rrd:net_close:MAX \
          DEF:b_min=net_disk.rrd:net_close:MIN \
          AREA:a_avg#3366ff:"Close       " \
          LINE1:a_avg#1a53ff \
          GPRINT:a_max:MAX:"MAX  %6.0lf" \
          GPRINT:a_min:MIN:"MIN  %6.0lf" \
          GPRINT:a_avg:AVERAGE:"AVG  %6.0lf\n" \
          AREA:b_avg#809fff:"Established " \
          LINE1:b_avg#002080 \
          GPRINT:b_max:MAX:"MAX  %6.0lf" \
          GPRINT:b_min:MIN:"MIN  %6.0lf" \
          GPRINT:b_avg:AVERAGE:"AVG  %6.0lf" \
          # > /dev/null 2>&1



/opt/bin/rrdtool graph "$GRAPHS_PATH/net_giga-${day}.png" \
              --start end-${day} --slope-mode \
              --title "Network interface egiga0" \
              --width 600 --height 200 \
              --imgformat PNG \
          DEF:a_avg=net_disk.rrd:net_giga_rx:AVERAGE \
          DEF:a_max=net_disk.rrd:net_giga_rx:MAX \
          DEF:a_min=net_disk.rrd:net_giga_rx:MIN \
          DEF:b_avg=net_disk.rrd:net_giga_tx:AVERAGE \
          DEF:b_max=net_disk.rrd:net_giga_tx:MAX \
          DEF:b_min=net_disk.rrd:net_giga_tx:MIN \
          AREA:a_avg#3366ff:"RX " \
          LINE1:a_avg#1a53ff \
          GPRINT:a_max:MAX:"MAX  %16.0lf" \
          GPRINT:a_min:MIN:"MIN  %16.0lf" \
          GPRINT:a_avg:AVERAGE:"AVG  %16.0lf\n" \
          AREA:b_avg#809fff:"TX " \
          LINE1:b_avg#002080 \
          GPRINT:b_max:MAX:"MAX  %16.0lf" \
          GPRINT:b_min:MIN:"MIN  %16.0lf" \
          GPRINT:b_avg:AVERAGE:"AVG  %16.0lf" \
          # > /dev/null 2>&1


/opt/bin/rrdtool graph "$GRAPHS_PATH/trans_traf-${day}.png" \
              --start end-${day} --slope-mode \
              --title "Transmission bytes in/out" \
              --width 600 --height 200 \
              --imgformat PNG \
          DEF:a_avg=net_disk.rrd:trans_down:AVERAGE \
          DEF:a_max=net_disk.rrd:trans_down:MAX \
          DEF:a_min=net_disk.rrd:trans_down:MIN \
          DEF:b_avg=net_disk.rrd:trans_upl:AVERAGE \
          DEF:b_max=net_disk.rrd:trans_upl:MAX \
          DEF:b_min=net_disk.rrd:trans_upl:MIN \
          AREA:a_avg#3366ff:"Download " \
          LINE1:a_avg#1a53ff \
          GPRINT:a_max:MAX:"MAX  %6.0lf" \
          GPRINT:a_min:MIN:"MIN  %6.0lf" \
          GPRINT:a_avg:AVERAGE:"AVG  %6.0lf\n" \
          AREA:b_avg#809fff:"Upload   " \
          LINE1:b_avg#002080 \
          GPRINT:b_max:MAX:"MAX  %6.0lf" \
          GPRINT:b_min:MIN:"MIN  %6.0lf" \
          GPRINT:b_avg:AVERAGE:"AVG  %6.0lf" \
          # > /dev/null 2>&1


/opt/bin/rrdtool graph "$GRAPHS_PATH/disk-${day}.png" \
              --start end-${day} --slope-mode \
              --title "Disk usage" \
              --width 600 --height 200 \
              --imgformat PNG \
          DEF:a_avg=net_disk.rrd:disk_used:AVERAGE \
          DEF:a_max=net_disk.rrd:disk_used:MAX \
          DEF:a_min=net_disk.rrd:disk_used:MIN \
          DEF:b_avg=net_disk.rrd:disk_avail:AVERAGE \
          DEF:b_max=net_disk.rrd:disk_avail:MAX \
          DEF:b_min=net_disk.rrd:disk_avail:MIN \
          AREA:a_avg#3366ff:"Disk used      " \
          LINE1:a_max#1a53ff \
          GPRINT:a_max:MAX:"MAX  %16.0lf" \
          GPRINT:a_min:MIN:"MIN  %16.0lf" \
          GPRINT:a_avg:AVERAGE:"AVG  %16.0lf\n" \
          AREA:b_avg#809fff:"Disk available " \
          LINE1:b_max#002080 \
          GPRINT:b_max:MAX:"MAX  %16.0lf" \
          GPRINT:b_min:MIN:"MIN  %16.0lf" \
          GPRINT:b_avg:AVERAGE:"AVG  %16.0lf" \
          # > /dev/null 2>&1


/opt/bin/rrdtool graph "$GRAPHS_PATH/ULMM-ULLI-${day}.png" \
              --start end-${day} --slope-mode \
              --title "Temperature in ULMM and ULLI" \
              --width 600 --height 200 \
              --imgformat PNG \
          DEF:a_avg=temp.rrd:ULMM:AVERAGE \
          DEF:a_max=temp.rrd:ULMM:MAX \
          DEF:a_min=temp.rrd:ULMM:MIN \
          DEF:b_avg=temp.rrd:ULLI:AVERAGE \
          DEF:b_max=temp.rrd:ULLI:MAX \
          DEF:b_min=temp.rrd:ULLI:MIN \
          AREA:a_avg#3366ff:"ULMM " \
          LINE1:a_avg#1a53ff \
          GPRINT:a_max:MAX:"MAX  %6.0lf" \
          GPRINT:a_min:MIN:"MIN  %6.0lf" \
          GPRINT:a_avg:AVERAGE:"AVG  %6.0lf\n" \
          AREA:b_avg#809fff:"ULLI " \
          LINE1:b_avg#002080 \
          GPRINT:b_max:MAX:"MAX  %6.0lf" \
          GPRINT:b_min:MIN:"MIN  %6.0lf" \
          GPRINT:b_avg:AVERAGE:"AVG  %6.0lf" \
          # > /dev/null 2>&1

done

cd $GRAPHS_PATH
echo "
<html>
<body>
<h2>STAT GRAPHS</h2>
<META HTTP-EQUIV=\"Refresh\" CONTENT=\"300\" >
<META HTTP-EQUIV=\"Cache-Control\" content=\"no-cache\" >
<META HTTP-EQUIV=\"Pragma\" CONTENT=\"no-cache\" >
<hr>
<br>
" > /mnt/HD/HD_a2/myScripts/web/mrtg/index2.html
ls | sed 's/^.*/<br\/><b>&<\/b><br\/><img src="graphs\/&"><br\/>/' >> /mnt/HD/HD_a2/myScripts/web/mrtg/index2.html

exit 0

