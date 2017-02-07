#!/bin/sh

echo "Reboot via SysRq !"
echo "Syncing and sleeping 2 secs"
sync
sleep 2
echo 1 > /proc/sys/kernel/sysrq
echo b > /proc/sysrq-trigger

