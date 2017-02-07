#!/mnt/HD/HD_a2/ffp/bin/bash


ARGV=("$@")

if [ -z "$ARGV" ]; then
    echo "Target not defined";
    exit;
fi

hddinfo=`df | grep $ARGV`

hddtotal=`echo $hddinfo |awk '{print $2}'`
hddused=`echo $hddinfo |awk '{print $3}'`

echo 0;
awk "BEGIN {print ($hddused/$hddtotal)*10000}";
echo 0;
echo 0;
