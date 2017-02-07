#!/mnt/HD/HD_a2/ffp/bin/bash
DATA=`vmstat 1 2 | tail -n1`
echo $DATA | awk '{print $14}'
echo $DATA | awk '{print $13}'
echo 0
echo 0
