#!/mnt/HD/HD_a2/ffp/bin/bash
DATA=`cat /proc/loadavg`
FIRST=`echo $DATA | cut -d" " -f1`
SECOND=`echo $DATA | cut -d" " -f3`
echo $FIRST*100 | bc
echo $SECOND*100 | bc
echo 0
echo 0
