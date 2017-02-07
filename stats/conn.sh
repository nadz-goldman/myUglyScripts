#!/mnt/HD/HD_a2/ffp/bin/bash
DATA=`/usr/bin/netstat -nt | grep ESTABLISHED | wc -l`
echo $DATA
DATA=`/usr/bin/netstat -nt | grep CLOSE_W | wc -l`
echo $DATA
echo 0
echo 0