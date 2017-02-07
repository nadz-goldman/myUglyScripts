#!/mnt/HD/HD_a2/ffp/bin/bash
DATA=`free -b | grep Mem`
echo $DATA | awk '{print $3}'
echo $DATA | awk '{print $7}'
echo 0
echo 0
