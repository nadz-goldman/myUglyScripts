#!/mnt/HD/HD_a2/ffp/bin/bash

#
# Script for MRTG
#

case $1 in
processes)
    # running processes
    cat /proc/loadavg | tr \/ " " | awk {'print $4'}
    # total processes
    cat /proc/loadavg | tr \/ " " | awk {'print $5'}
;;
 
cpuload)
    cat /proc/loadavg | awk {'print $1'}
    cat /proc/loadavg | awk {'print $2'}
;;
 
network-established)
    /usr/bin/netstat -nt | grep CLOSE_W | wc -l
    /usr/bin/netstat -nt | grep ESTABLISHED | wc -l
;;

network-bytes)
    DATA=`grep egiga0 /proc/net/dev`
    # RX
    echo $DATA | awk '{print $2}'
    # TX
    echo $DATA | awk '{print $10}'
;;

transmission-bytes)
    downloaded=$( grep downloaded /mnt/HD/HD_a2/.systemfile/P2P/.settings/stats.json | awk {'print $2'} | tr , " " )
    uploaded=$( grep uploaded /mnt/HD/HD_a2/.systemfile/P2P/.settings/stats.json | awk {'print $2'} | tr , " " )
    let "downloaded = $downloaded / 1073741824"
    let "uploaded = $uploaded / 1073741824"
    echo $downloaded
    echo $uploaded
;;

disk-usage)
    diskUsed=$( df | grep md1 | awk {'print $3'} )
    diskAvailable=$( df | grep md1 | awk {'print $4'} )
    let "diskUsed = $diskUsed / 100000"
    let "diskAvailable = $diskAvailable / 100000"
    echo $diskUsed
    echo $diskAvailable
;;

uptime)
    uptime=$(</proc/uptime)
    uptime=${uptime%%.*}
    days=$(( uptime/60/60/24 ))
    echo $days
;;

vmstat-user-system)
    DATA=`vmstat 1 2 | tail -n1`
    echo $DATA | awk '{print $14}'
    echo $DATA | awk '{print $13}'
;;

memory)
    # mem total and used
    DATA=`free -m | grep Mem`
    echo $DATA | awk '{print $2}'
    echo $DATA | awk '{print $3}'
;;

temp)
    temp=$(fan_control -g 0 | awk '{print $4}')
    echo $temp
;;

tempULMM-ULLI)
    t1=$( /opt/bin/curl -s -L "https://api.openweathermap.org/data/2.5/weather?id=524305&appid=SECRET-TOKEN&units=metric" | sed -e 's/[{}]/''/g' | awk -v RS=',"' -F: '/^temp_min/ {print $2}' )
    t2=$( /opt/bin/curl -s -L "https://api.openweathermap.org/data/2.5/weather?id=536203&appid=SECRET-TOKEN&units=metric" | sed -e 's/[{}]/''/g' | awk -v RS=',"' -F: '/^temp_min/ {print $2}' )
# Magic!
# Because MRTG can not operate with negative numbers!
# Yes! MRTG! Negative numbers! Year 2018!!!
# Olololo!!!!!
    r1=$(( 0 > t1  ))
    if [[ $r1 -eq 1 ]] ; then
        r11=$(( 100$t1 ))
        echo $r11
    else
        r11=$(( 100+$t1 ))
        echo $r11
    fi

    r1=$(( 0 > t2  ))
    if [[ $r1 -eq 1 ]] ; then
        r11=$(( 100$t2 ))
        echo $r11
    else
        r11=$(( 100+$t2 ))
        echo $r11
    fi
;;

*)
    echo "* Usage: $0 "
    echo "         processes | cpuload"
    echo "         network-established | network-bytes | transmission-bytes"
    echo "         disk-usage | vmstat-user-system | memory"
    echo "         uptime"
    echo "         temp | tempULMM-ULLI"
    exit 1
;;
esac

exit 0
