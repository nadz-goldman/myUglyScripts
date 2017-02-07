#!/mnt/HD/HD_a2/ffp/bin/bash

DATA=`grep egiga0 /proc/net/dev`
echo $DATA | awk '{print $2}'
echo $DATA | awk '{print $10}'
echo 0
echo 0

