#!/mnt/HD/HD_a2/ffp/bin/bash

#DATA=`df -B1 | grep md1`
#echo $DATA | awk '{print $3}'
#echo $DATA | awk '{print $2}'

#DATA=$( df -B1 | grep md1 | awk '{print $2}' )
#T=$( echo $DATA/\(1024*1024*1024\) | bc )
#echo $T
#DATA=$( df -B1 | grep md1 | awk '{print $3}' )
#T=$( echo $DATA/\(1024*1024*1024\) | bc )
#echo $T

#/mnt/HD/HD_a2/.systemfile/P2P/.settings/stats.json

down=$( grep -Po '"downloaded-bytes":.*?[^\\]",' /mnt/HD/HD_a2/.systemfile/P2P/.settings/stats.json )
up=$(   grep -Po '"uploaded-bytes":.*?[^\\]",' /mnt/HD/HD_a2/.systemfile/P2P/.settings/stats.json )
echo $down
echo $up
echo 0
echo 0
