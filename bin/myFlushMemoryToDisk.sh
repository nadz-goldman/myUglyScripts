#!/bin/sh

printf "\n\nDrop Cache\nBefore\n"
free -m
sync
echo 3 > /proc/sys/vm/drop_caches
printf "\nAfter Drop Cache\n"
free -m

printf "\nTurn off swap\n"
swapoff -a
printf "\nTurn on swap\n"
swapon -a
printf "\nTMemory after switching swap\n"
free -m
printf "\n"
